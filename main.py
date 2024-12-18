"""Demo usage of Digital RF metadata management."""

from pathlib import Path
from pprint import pprint
from typing import TYPE_CHECKING, NamedTuple, cast

import digital_rf as drf
from loguru import logger as log

if TYPE_CHECKING:
    import numpy as np


def main() -> None:
    """Reads a simple Digital RF data file."""
    # parameters
    data_path = Path("fake-data") / "drf"
    data_path.mkdir(parents=True, exist_ok=True)

    # read metadata
    rf_reader = drf.DigitalRFReader(str(data_path))
    channels: list[str] = rf_reader.get_channels()
    log.debug(channels)
    channel_name = channels[0]

    bounds_raw = rf_reader.get_bounds(channel_name)
    bounds_raw = cast(tuple[int, int], bounds_raw)
    bounds = Bounds(start=bounds_raw[0], end=bounds_raw[1])
    log.info(f"Bounds: from {bounds.start:,} to {bounds.end:,}")

    all_metadata = rf_reader.read_metadata(
        start_sample=bounds.start,
        end_sample=bounds.end,
        channel_name=channel_name,
    )
    pprint(all_metadata)

    # read sample
    data: np.ndarray = rf_reader.read_vector(
        start_sample=bounds.start,
        vector_length=bounds.size,
        channel_name=channel_name,
    )
    log.info(f"Data summary: {data.shape} <{data.dtype}>")
    log.info(f"Data contents: {data}")


class Bounds(NamedTuple):
    """Represents a continuous range, inclusive."""

    start: int
    end: int

    def __postinit__(self, start: int, end: int) -> None:
        if start >= end:
            msg = f"Start '{start}' must be less than end '{end}'"
            raise ValueError(msg)

    @property
    def size(self) -> int:
        """Returns the size of the range (inclusive)."""
        return self.end - self.start + 1

    def __len__(self) -> int:
        """Alias for self.size."""
        return self.size


if __name__ == "__main__":
    main()

#!/usr/bin/env -S MPLBACKEND=Agg uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
# "natsort",
# "numpy",
# "matplotlib",
# "tqdm"
# ]
# ///

import glob
import os
from argparse import ArgumentParser

import matplotlib.pyplot as plt
import numpy as np
import tqdm
from natsort import natsorted


def plot_spectrograms(args):
    os.makedirs(args.output_dir, exist_ok=True)

    # print(glob.glob(args.input_paths))

    for input_path in tqdm.tqdm(natsorted(glob.glob(args.input_paths))):
        # print(input_path)
        iq_data = np.fromfile(input_path, dtype=np.complex64)
        plt.specgram(iq_data)

        out_path = os.path.join(args.output_dir, f"{os.path.basename(input_path)}.png")
        plt.title(out_path)
        plt.savefig(out_path)
        plt.clf()


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "-i",
        "--input_paths",
        type=str,
        required=True,
        help="Globbable paths to IQ data files",
    )
    parser.add_argument(
        "-o",
        "--output_dir",
        type=str,
        required=True,
        help="Directory to save output spectrograms",
    )
    args = parser.parse_args()
    plot_spectrograms(args)

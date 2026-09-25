# Digital Filters in MATLAB

MATLAB implementations of classical digital filters applied to audio signals. The project compares **Butterworth**, **Chebyshev Type I**, **Chebyshev Type II**, and **Elliptic** filters using low-pass, high-pass, and band-pass configurations.

## Project Structure

```text
Digital_Filters_MATLAB/
├── BUTTERWORTH_FILTERS/
│   ├── LOWPASS_FILTER_BUTTERWORTH.m
│   ├── HIGHPASS_FILTER_BUTTERWORTH.m
│   ├── BANDPASS_FILTER_BUTTERWORTH.m
│   └── handel.wav
├── CHEBYSHEV_TYPE_I_FILTERS/
│   ├── LOWPASS_FILTER_CHEBYSHEV_1.m
│   ├── HIGHPASS_FILTER_CHEBYSHEV_1.m
│   ├── BANDPASS_FILTER_CHEBYSHEV_1.m
│   └── handel.wav
├── CHEBYSHEV_TYPE_II_FILTERS/
│   ├── LOWPASS_FILTER_CHEBYSHEV_2.m
│   ├── HIGHPASS_FILTER_CHEBYSHEV_2.m
│   ├── BANDPASS_FILTER_CHEBYSHEV_2.m
│   └── handel.wav
└── ELLIPTIC_FILTERS/
    ├── LOWPASS_FILTER_ELLIPTIC.m
    ├── HIGHPASS_FILTER_ELLIPTIC.m
    ├── BANDPASS_FILTER_ELLIPTIC.m
    └── handel.wav
```

## Implemented Filters

| Filter family | Low-pass | High-pass | Band-pass |
|---|:---:|:---:|:---:|
| Butterworth | ✓ | ✓ | ✓ |
| Chebyshev Type I | ✓ | ✓ | ✓ |
| Chebyshev Type II | ✓ | ✓ | ✓ |
| Elliptic | ✓ | ✓ | ✓ |

## What Each Script Does

Each MATLAB script follows the same general workflow:

1. Reads an audio file and obtains its sampling frequency.
2. Computes the FFT of the original signal.
3. Plots the magnitude spectrum of the original audio.
4. Defines passband and stopband specifications.
5. Calculates the required filter order and cutoff frequency.
6. Generates the corresponding IIR filter coefficients.
7. Plots the filter frequency response.
8. Applies the filter to the audio signal.
9. Computes and plots the FFT of the filtered signal.
10. Plays the filtered audio.

## MATLAB Functions Used

The project uses functions including `audioinfo`, `audioread`, `fft`, `buttord`, `butter`, `cheb1ord`, `cheby1`, `cheb2ord`, `cheby2`, `ellipord`, `ellip`, `freqz`, `filter`, and `sound`.

## Requirements

- MATLAB
- Signal Processing Toolbox
- An audio file with the filename expected by each script

## Running a Script

Open MATLAB, change the current folder to one of the filter-family directories, and run the desired `.m` file. For example:

```matlab
LOWPASS_FILTER_BUTTERWORTH
```

The script displays the original spectrum, the filter frequency response, and the filtered spectrum, then plays the filtered signal.

## Important Note About the Audio Files

The Butterworth and Chebyshev scripts reference `handel.wav`, which is included in their directories. The original Elliptic scripts reference `Yabu_mono.wav`, while the uploaded Elliptic directory contains `handel.wav`. This mismatch has intentionally **not** been corrected because the MATLAB code was not to be modified. To run those scripts unchanged, place `Yabu_mono.wav` in `ELLIPTIC_FILTERS/`.

## Code Preservation

The numerical parameters, MATLAB functions, variables, filter definitions, calculations, plotting commands, and processing sequence were preserved. Only human-readable Spanish comments, plot labels/titles, and file/folder names were translated to English.

## Filter Families

### Butterworth
Provides a maximally flat magnitude response in the passband.

### Chebyshev Type I
Allows passband ripple in exchange for a sharper transition than a Butterworth filter of comparable order.

### Chebyshev Type II
Uses ripple in the stopband while keeping the passband monotonic.

### Elliptic
Uses ripple in both passband and stopband and generally achieves a very sharp transition for a given filter order.

## Purpose

This repository is intended as a practical MATLAB exercise for studying digital IIR filter design, frequency-domain analysis, and audio filtering.

## License

No license was included in the original project. Add a license file if you plan to distribute or reuse the project publicly.

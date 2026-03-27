#!/usr/bin/env python3
"""
comsol_convergence_plot_offline.py

Parses a COMSOL batch log containing the time-dependent solver step table:
Step Time Stepsize Res Jac Sol Order Tfail NLfail LinIt LinErr LinRes

Generates a single stacked PNG with:
- LinIt (log scale) + quality bands + labels
- LinErr (log scale) + quality bands + labels
- Failure markers (Tfail or NLfail > 0) as black X's along the bottom
- Top x-axis showing cumulative simulation time
- Major/minor mesh (grid) on both axes
- Legend in lower right
- Explanatory text boxes in LOWER LEFT of each subplot

Usage:
  python comsol_convergence_plot_offline.py comsol_batch.out
  python comsol_convergence_plot_offline.py comsol_batch.out --out comsol_convergence.png

Optional:
  --csv parsed.csv   to save parsed table

Notes:
- Band thresholds are rule-of-thumb; tune if desired.
"""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def is_float(s: str) -> bool:
    try:
        float(s)
        return True
    except Exception:
        return False


def parse_step_table(text: str) -> pd.DataFrame:
    rows = []
    for line in text.splitlines():
        s = line.strip()
        if not s:
            continue
        if s.startswith(("-", "<", ">", "Memory:")):
            continue

        toks = s.split()
        # Step Time Stepsize Res Jac Sol Order Tfail NLfail LinIt LinErr LinRes
        if len(toks) != 12:
            continue
        if not toks[0].isdigit():
            continue
        if not (is_float(toks[1]) and is_float(toks[2])):
            continue
        if not (toks[7].isdigit() and toks[8].isdigit() and toks[9].isdigit()):
            continue
        if not is_float(toks[10]):
            continue

        rows.append(
            {
                "step": int(toks[0]),
                "time": float(toks[1]),
                "stepsize": float(toks[2]),
                "tfail": int(toks[7]),
                "nlfail": int(toks[8]),
                "lin_it": int(toks[9]),
                "lin_err": float(toks[10]),
            }
        )

    df = pd.DataFrame(rows).sort_values("step").reset_index(drop=True)
    return df


def add_time_top_axis(ax, steps, times, n_ticks: int = 6) -> None:
    ax_top = ax.twiny()
    ax_top.set_xlim(ax.get_xlim())
    idx = np.linspace(0, len(steps) - 1, n_ticks).astype(int)
    ax_top.set_xticks(steps.iloc[idx])
    ax_top.set_xticklabels([f"{times.iloc[i]:.1f}" for i in idx])
    ax_top.set_xlabel("Cumulative simulation time")


def add_mesh(ax) -> None:
    ax.minorticks_on()
    ax.grid(True, which="major", axis="both", linestyle="--", linewidth=0.8, alpha=0.6)
    ax.grid(True, which="minor", axis="both", linestyle=":", linewidth=0.6, alpha=0.4)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("logfile", type=str, help="Path to COMSOL log file (e.g., comsol_batch.out)")
    ap.add_argument("--out", type=str, default="comsol_convergence_stacked_annotated.png", help="Output PNG path")
    ap.add_argument("--csv", type=str, default="", help="Optional output CSV path")

    # Bands (rule-of-thumb defaults)
    ap.add_argument("--linIt-green-max", type=float, default=1000.0)
    ap.add_argument("--linIt-yellow-max", type=float, default=5000.0)
    ap.add_argument("--linErr-green-max", type=float, default=1e-4)
    ap.add_argument("--linErr-yellow-max", type=float, default=1e-3)

    args = ap.parse_args()

    log_path = Path(args.logfile)
    if not log_path.exists():
        raise FileNotFoundError(f"Log file not found: {log_path}")

    df = parse_step_table(log_path.read_text(errors="ignore"))
    if df.empty:
        raise RuntimeError("No COMSOL step-table rows were parsed. Confirm the 12-column step table exists in the log.")

    if args.csv:
        Path(args.csv).parent.mkdir(parents=True, exist_ok=True)
        df.to_csv(args.csv, index=False)

    fail_mask = (df["tfail"] + df["nlfail"]) > 0

    linIt_green_max = args.linIt_green_max
    linIt_yellow_max = args.linIt_yellow_max
    linErr_green_max = args.linErr_green_max
    linErr_yellow_max = args.linErr_yellow_max

    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(11, 9), sharex=True)

    # ---------- LinIt subplot ----------
    ymax_it = max(df["lin_it"].max() * 1.5, linIt_yellow_max * 2)

    ax1.axhspan(1, linIt_green_max, facecolor="green", alpha=0.12)
    ax1.axhspan(linIt_green_max, linIt_yellow_max, facecolor="yellow", alpha=0.18)
    ax1.axhspan(linIt_yellow_max, ymax_it, facecolor="red", alpha=0.10)

    ax1.plot(df["step"], df["lin_it"], color="tab:blue", linewidth=2.0, label="LinIt")

    ax1.set_yscale("log")
    ax1.set_ylabel("LinIt (log scale)")
    ax1.set_ylim(1, ymax_it)
    add_mesh(ax1)

    ymin_it = max(1, df["lin_it"].min())
    if fail_mask.any():
        ax1.scatter(
            df.loc[fail_mask, "step"],
            np.full(int(fail_mask.sum()), ymin_it),
            color="black",
            s=18,
            marker="x",
            label="Tfail/NLfail",
        )

    xmid = (df["step"].min() + df["step"].max()) / 2
    ax1.text(xmid, 200, "Good\n(<1k)", ha="center", va="center")
    ax1.text(xmid, 2500, "Watch\n(1k–5k)", ha="center", va="center")
    ax1.text(xmid, max(12000, linIt_yellow_max * 2), "Struggling\n(>5k)", ha="center", va="center")

    # Explanatory box (LOWER LEFT)
    linIt_text = (
        "LinIt = linear solver iterations per time step\n"
        "Low: well-conditioned system\n"
        "High: poor conditioning / strong coupling\n"
        "Upward trend → solver working harder\n"
        "Failures → time step reductions"
    )
    ax1.text(
        0.01,
        0.02,
        linIt_text,
        transform=ax1.transAxes,
        va="bottom",
        ha="left",
        fontsize=9,
        bbox=dict(boxstyle="round", facecolor="white", alpha=0.85),
    )

    add_time_top_axis(ax1, df["step"], df["time"])
    ax1.legend(loc="lower right", framealpha=0.9)

    # ---------- LinErr subplot ----------
    y_top = max(df["lin_err"].max() * 1.5, linErr_yellow_max * 10)
    y_bottom = min(max(df["lin_err"].min() / 10, 1e-12), linErr_green_max / 100)

    ax2.axhspan(y_bottom, linErr_green_max, facecolor="green", alpha=0.12)
    ax2.axhspan(linErr_green_max, linErr_yellow_max, facecolor="yellow", alpha=0.18)
    ax2.axhspan(linErr_yellow_max, y_top, facecolor="red", alpha=0.10)

    ax2.plot(df["step"], df["lin_err"], color="tab:red", linewidth=2.0, label="LinErr")

    ax2.set_yscale("log")
    ax2.set_ylabel("LinErr (log scale)")
    ax2.set_xlabel("Time step index")
    ax2.set_ylim(y_bottom, y_top)
    add_mesh(ax2)

    if fail_mask.any():
        ax2.scatter(
            df.loc[fail_mask, "step"],
            np.full(int(fail_mask.sum()), max(y_bottom, df["lin_err"].min())),
            color="black",
            s=18,
            marker="x",
            label="Tfail/NLfail",
        )

    ax2.text(xmid, max(y_bottom * 10, linErr_green_max / 30), "Tight", ha="center", va="center")
    ax2.text(xmid, np.sqrt(linErr_green_max * linErr_yellow_max), "Moderate", ha="center", va="center")
    ax2.text(xmid, max(linErr_yellow_max * 3, 2e-3), "Loose", ha="center", va="center")

    # Explanatory box (LOWER LEFT)
    linErr_text = (
        "LinErr = relative linear solver residual\n"
        "Low: accurate linear solve\n"
        "High: loose tolerance or difficult system\n"
        "Stable LinErr + high LinIt → conditioning issue\n"
        "Failures → stiffness/nonlinear difficulty"
    )
    ax2.text(
        0.01,
        0.02,
        linErr_text,
        transform=ax2.transAxes,
        va="bottom",
        ha="left",
        fontsize=9,
        bbox=dict(boxstyle="round", facecolor="white", alpha=0.85),
    )

    ax2.legend(loc="lower right", framealpha=0.9)

    plt.tight_layout()
    out_path = Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=200)
    plt.close(fig)

    print(f"Wrote: {out_path}")
    if args.csv:
        print(f"Wrote: {args.csv}")
    print(f"Parsed rows: {len(df)}")


if __name__ == "__main__":
    main()

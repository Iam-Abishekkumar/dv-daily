# dv-daily

Daily Design Verification interview practice, one question at a time.
Goal: DV engineer at NVIDIA / Google.

Each commit = one interview question answered in my own words.

## Topics (120 questions)

| Folder | Topic | Questions |
|---|---|---|
| `answers/sv` | SystemVerilog | 22 |
| `answers/uvm` | UVM | 20 |
| `answers/sva` | SVA and formal (FPV) | 18 |
| `answers/amba` | APB / AHB / AXI | 18 |
| `answers/design` | Digital design, CDC, AI accelerators | 18 |
| `answers/linux` | Linux, Vim, Git, Make | 12 |
| `answers/cpp` | C++ / coding problems | 12 |

Topics rotate, so 3 questions a day always cover 3 different topics.

## Daily routine (2-5 minutes each)

```
./push.sh      # morning
./push.sh      # afternoon
./push.sh      # night
```

The script shows the next question, opens the answer file in Vim,
and after you save it commits and pushes. If you leave the answer
empty, nothing is committed.

## Progress

See [PROGRESS.md](PROGRESS.md) for the full log.

## Add more questions

Add a line to `questions.tsv`: topic, a TAB, then the question.

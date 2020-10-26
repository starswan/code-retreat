Learnings from session one:

we tried 'mob programming' with 4 participants, however VS Code (the chosen pairing tool) only has a single cursor
which made code collaboration difficult in a group.

The group spent a long time 'storming' so the 2x45 minute sessions became 1x90 minute session - meaningful work started around the 30 minute mark

VS Code didn't always put everyone on the same tab - so sometimes conversations were confusing as xsome group members were discussing a
tab view whilst other members of the group were looking at a different tab - think there is a 'follow' option to fix this.

The second test written (3 in a line) was given the wromg expectation - the group focussed on one rule (staying alive) whilst
ignoring the second rule (birth) resulting in an incorrect test. However writing a scenario with only 2 adjacent cells whilst
being alive yourself seems quite difficult to avoid the '3 cells birth' rule as well - the group could not decide how to deal with this
(during the post-mortem)

The tests written were not precise enough - they only checked size -= but possibly the problem above ^ could have been addressed by checking
the 'liveness' of specific cells rather than the whole solution.
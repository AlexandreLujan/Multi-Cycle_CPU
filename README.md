# Single-Cycle_CPU
-Implementation of a Simple Processor in VHDL.<br />
-One Instruction per Cycle.<br />
-Control unit based on a finite state machine.<br />
-Opcode 011 (Debug) stop the processor, preventing any new instruction.<br />
-All instructions are loaded from ROM and can save the result in RAM.<br />

## Built With
-Quartus Prime Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition<br />
(Copyright (C) 2020 Intel Corporation. All rights reserved).

## Circuit Schematic
![alt text](https://github.com/AlexandreLujan/Single-Cycle_CPU/blob/main/Schematic.jpg?raw=true)

## Instructions
![alt text](https://github.com/AlexandreLujan/Single-Cycle_CPU/blob/main/Opcode.png?raw=true)

## State Machine
![alt text](https://github.com/AlexandreLujan/Single-Cycle_CPU/blob/main/State_Machine.jpg?raw=true)

## Simulation
-Simulation result using ModelSim-Altera contained in Quartus.<br />
-Note: This project uses a testbench and it needs to be loaded into the simulation.<br />
![alt text](https://github.com/AlexandreLujan/Single-Cycle_CPU/blob/main/Simulation_1.jpg?raw=true)
![alt text](https://github.com/AlexandreLujan/Single-Cycle_CPU/blob/main/Simulation_2.jpg?raw=true)



## Description

The goal of this project is measuring the reverberation criteria RT60 and RT30 with no knowledge about the room's volume or content. First a logsweep is played in the room and then recorded using a microphone. Once the audio is recorded it's then processed to obtain the energy's curve and later calculate the RT60. 

## Algorithm 

![alt text](https://github.com/HMMalek/ReverberationMeasurement/blob/master/Flowchart.png "Algorithm Flowchart")

## Details

Please refer to the description file for more information concerning the entire process.

## Architecture 

The process of measurement is divided into two phases: 

| Phase 1 | Description | Matlab file
| :---: |:---: | :---: | 
|Emit/Record |  the first phase is emitting the log sweep in the room for 5,5s and recording it (The tests for this project were done using a phantom speaker and an Audix TM1 microphone). | Recording_reverberations |

| Phase 2 | Description | Matlab file 
| :---: | :---: | :---: |
|Calculate reverberation | The second phase is actually calculating the RT60 from the energy curve registred | Curve_RT30 is the main file which will call the other 3 functions. |





# MicroPrints in GToolkit

MicroPrints provide a pixel-based representation of text files or source code enriched with semantical information. 
They can help understanding of software systems [Robbes, Ducasse & Lanza](https:/scg.unibe.ch/archive/papers/Robb05b-microprintsESUG.pdf)

![alt](https://github.com/StephanEggermont/GtMicroPrints/MicroPrint.png)

## Installation

```st
Metacello new
	repository: 'github://StephanEggermont/GtMicroPrints:main/src';
	baseline: 'GtMicroPrints';
	load
```

## Load Lepiter

After installing with Metacello, you will be able to execute

```
#BaselineOfGtMicroPrints asClass loadLepiter
```

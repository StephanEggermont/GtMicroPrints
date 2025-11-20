# MicroPrints in GToolkit

MicroPrints provide a pixel-based representation of text files or source code enriched with semantical information. 
They can help understanding of software systems [Robbes, Ducasse & Lanza](https:/scg.unibe.ch/archive/papers/Robb05b-microprintsESUG.pdf)

<img width="824" height="824" alt="MicroPrint" src="https://github.com/user-attachments/assets/caaf5b79-f515-45af-a168-94d2c26a98e6" />

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

and then find the main documentation page in 'Knowledge bases'

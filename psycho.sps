SET DECIMAL=DOT.

DATA LIST FILE= "psycho.sav"  free (",")
ENCODING="Locale"
/ Participant_ID * Treatment (A10) Neuroticism 
  .

VARIABLE LABELS
Participant_ID "Participant_ID" 
 Treatment "Treatment" 
 Neuroticism "Neuroticism" 
 .
VARIABLE LEVEL Participant_ID, Neuroticism 
 (scale).

EXECUTE.

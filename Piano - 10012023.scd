MIDIClient.init; // Turn on midi
MIDIIn.connectAll; // Let SC talk to all of your midi inputs
m = MIDIOut.new(0); // Use the first connected midi device, in my case: Apple Inc. - IAC Driver - Bus 1
m.latency = 0.3; // Proly good to match s.latency value here
(
(
Pdef(0,
	Pbind(*[
		type: Pwrand2([\midi, \], [1, 7], inf),
		midiout: m,
		chan: 0,
		scale: Pdup(Plprand(9, 19), Pxshuf([
			Scale.harmonicMinor,
			Scale.minor,
			Scale.major,
			Scale.mixolydian,
			Scale.aeolian,
			Scale.phrygian,
			Scale.whole,
			Scale.pelog,
			Scale.ionian,
			Scale.chromatic,
		], inf)),
		mtranspose: Pdup(Plprand(29, 39), Pstep(Prand([0, 2, -1, -2, -4, -5, -7, -8], inf), 2, inf)),
		octave: Pdup(Plprand(1, 4), Pmeanrand(3, 7)).round,
		degree: Pdup(Plprand(19, 29), Prand([0, 1, 2, 4, 6, 7, 8, 10, 12], inf)),
		amp: Pseg(Pdup(2, Plprand(0.01, 0.75)), Plprand(1.0, 19.0), \wel, inf),
		dur: 1.0 / Pseg(Pdup(2, Pexprand(5, 11).linlin(5, 11, 11, 5)), Plprand(1.0, 9.0), \wel, inf),
		stretch: Pseg(Pwhite(0.75, 1.5), Plprand(1.0, 9.0), \wel, inf),
	])
).play;
);
(
Pbind(*[
	type: \midi,
	midiout: m,
	midicmd: \control,
	chan: 0,
	ctlNum: 64,
	control: 127,
	dur: Pexprand(1, 100).round,
]).play;
);
CmdPeriod.doOnce {
	// release any hanging notes
	m.allNotesOff(0);
};
)


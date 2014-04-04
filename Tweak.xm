%hook UISlider

- (void)setThumbImage:(id)arg1 forState:(unsigned int)arg2 {
	NSLog(@"[SliderFrenzy] STATE2: %d", arg2);
	%orig;
}

- (void)setThumbImage:(id)arg1 forStates:(unsigned int)arg2 {
	NSLog(@"[SliderFrenzy] STATE3: %d", arg2);
	%orig;
}

- (id)_thumbImageForState:(unsigned int)arg1 {
	NSLog(@"[SliderFrenzy] STATE1: %d", arg1);
	return %orig;
}

%end
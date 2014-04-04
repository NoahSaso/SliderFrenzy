%hook UISlider

- (void)setThumbImage:(id)arg1 forState:(unsigned int)arg2 {
	NSLog(@"[SliderFrenzy] STATE: %d", arg2);
	%orig;
}

- (id)_thumbImageForState:(unsigned int)arg1 {
	return %orig;
}

%end
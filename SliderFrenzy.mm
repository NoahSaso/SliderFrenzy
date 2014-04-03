#import <Preferences/Preferences.h>

#define url(x) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:x]];

@interface SliderFrenzyListController: PSListController {
}
- (void)openTwitter;
- (void)openDonate;
- (void)openWebsite;
@end

@implementation SliderFrenzyListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"SliderFrenzy" target:self] retain];
	}
	return _specifiers;
}
- (void)openTwitter {
	url(@"http://twitter.com/Sassoty");
}
- (void)openDonate {
	url(@"http://bit.ly/sassotypp");
}
- (void)openWebsite {
	url(@"http://sassoty.com");
}
@end

// vim:ft=objc

@interface ThemesListController : PSViewController <UITableViewDelegate, UITableViewDataSource> {
}
@property (strong, nonatomic) UITableView *tabView;
@property (strong, nonatomic) NSMutableArray *listArray;
@property (nonatomic) int indexToCheck;
@end

@implementation ThemesListController

- (void)viewDidLoad {

	[self.view setBackgroundColor:[UIColor whiteColor]];

	self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];

	self.tabView.delegate = self;
    self.tabView.dataSource = self;
    [self.tabView setAlwaysBounceVertical:YES];

    self.listArray = [[NSMutableArray alloc] init];

    NSError *error;
	NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/SliderFrenzy/" error:&error];

	for(int i = 0; i < [directoryContents count]; i++){
		[self.listArray addObject:[directoryContents objectAtIndex:i]];
	}

	NSString *settingsPath = @"/var/mobile/Library/Preferences/com.sassoty.sliderfrenzy.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	NSString *themeKey = [prefs objectForKey:@"theme"];

	if([themeKey isEqualToString:@""] || themeKey == nil){
		self.indexToCheck = -1;
	}else{
		self.indexToCheck = [self.listArray indexOfObject:themeKey];
	}

    [self.view addSubview:self.tabView];
    [self.tabView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Themes";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    int row = indexPath.row;

    NSString *settingsPath = @"/var/mobile/Library/Preferences/com.sassoty.sliderfrenzy.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];

    if(self.indexToCheck == row){
    	self.indexToCheck = -1;
    	[prefs removeObjectForKey:@"theme"];
    }else{
    	self.indexToCheck = row;
		[prefs setValue:[self.listArray objectAtIndex:row] forKey:@"theme"];
    }

    [prefs writeToFile:settingsPath atomically:YES];

    [self.tabView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tabView reloadData];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", str];

    NSString *cellName = [self.listArray objectAtIndex:indexPath.row];

    if(self.indexToCheck == indexPath.row){
    	cell.accessoryView = [[UIImageView alloc] initWithImage:[_UIImageWithName(@"UIPreferencesBlueCheck.png") retain]];
    }else{
    	cell.accessoryView = nil;
    }

    cell.textLabel.text = cellName;

    NSString *folderPath = [@"/Library/SliderFrenzy/" stringByAppendingString:cellName];
    cell.imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Icon.png", folderPath]];

    return cell;
    
}

@end

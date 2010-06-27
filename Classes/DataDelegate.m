//
//  DataDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "DataDelegate.h"
#import "Line.h"
#import	"Tip.h"
#import "Goal.h"
#import "Exercise.h"

@implementation DataDelegate

@synthesize lines, tips, goals, exercises;

-(void)initialize_data {
	lines = [[NSMutableArray alloc] init];
	tips = [[NSMutableArray alloc] init];
	goals = [[NSMutableArray alloc] init];
	exercises = [[NSMutableArray alloc] init];
	
	Line *l = [[Line alloc] init];
	l.phrasing = @"Will you forgive me when I forget to walk the dog?";
	[lines addObject:l];

	l = [[Line alloc] init];
	l.phrasing = @"Pardon me, do you know where there's a camera store around here?";
	[lines addObject:l];

	l = [[Line alloc] init];
	l.phrasing = @"You must have quite a mission today, with a look like that on your face.";
	[lines addObject:l];

	l = [[Line alloc] init];
	l.phrasing = @"Okay, you're on BBC one, interview time, who's the biggest influence in your life?";
	[lines addObject:l];

	l = [[Line alloc] init];
	l.phrasing = @"Who lies more, a fish or a chicken?";
	[lines addObject:l];
	
	Tip *t = [[Tip alloc] init];
	t.advice = @"Don't ask more than two questions in a row.";
	[tips addObject:t];

	t = [[Tip alloc] init];
	t.advice = @"Don't lose your cool if she tests you, like accusing you of being a player.";
	[tips addObject:t];

	t = [[Tip alloc] init];
	t.advice = @"You should talk about something that you both have in common; find it by listening to what she says.";
	[tips addObject:t];

	t = [[Tip alloc] init];
	t.advice = @"You can turn questions into statements; she'll answer anyway and it will make her curious.";
	[tips addObject:t];

	t = [[Tip alloc] init];
	t.advice = @"You should try to engage her (say something to her) three times before going away, even if she doesn't respond to the first two.";
	[tips addObject:t];
	
	Exercise *e = [[Exercise alloc] init];
	e.name = @"Warm up";
	e.description = @"Walk up to somebody, give them a compliment, and walk away.  Repeat 3-6 times.";
	[exercises addObject:e];

	e = [[Exercise alloc] init];
	e.name = @"Hired guns on duty";
	e.description = @"When a clerk asks if they can help you, smile and joke 'Oh my goodness, I thought you would never ask!' or say something else they don't expect.";
	[exercises addObject:e];

	e = [[Exercise alloc] init];
	e.name = @"Questions";
	e.description = @"This exercise requires more than one person. When it is your turn you ask someone a question. It is now their turn, and they must ask a question. If someone answers a question they lose - you must concentrate, ignore what you have been asked, and ask a question of your own.";
	[exercises addObject:e];
	
	e = [[Exercise alloc] init];
	e.name = @"Male Cleavage";
	e.description = @"Practice walking around with your mouth slightly open, or at least make sure your jaw is relaxed. Wear sunglasses and you will get oggled even more (because girls can't tell if you catch them checking you out)!";
	[exercises addObject:e];
	
	e = [[Exercise alloc] init];
	e.name = @"Flash the Clown (grin)";
	e.description = @"After you make eye contact with a girl for a second or two, flash your biggest grin.";
	[exercises addObject:e];
	
	Goal *g = [[Goal alloc] init];
	g.description = @"Ask for directions even though you know the way.";
	[goals addObject:g];
	
	g = [[Goal alloc] init];
	g.description = @"Talk to the first tall girl you see today.";
	[goals addObject:g];

	g = [[Goal alloc] init];
	g.description = @"Touch her on the arm every time you use a ? or a !";
	[goals addObject:g];

	g = [[Goal alloc] init];
	g.description = @"Don't break eye contact until after she does.";
	[goals addObject:g];

	g = [[Goal alloc] init];
	g.description = @"Repeat her name after you learn it.";
	[goals addObject:g];
}

@end

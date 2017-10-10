//
//  RecipeTableViewCell.m
//  xCook
//
//  Created by macbook on 7/20/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "RecipeTableViewCell.h"

@interface RecipeTableViewCell()


@end


@implementation RecipeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageRecipe.layer.masksToBounds = YES;
    //self.imageRecipe.layer.cornerRadius = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

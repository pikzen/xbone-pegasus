# Xbox One Dashboard

![Preview](https://i.imgur.com/pRHBnLb.jpg)

This is a theme aiming to recreate something similar to an Xbox One Dashboard for Pegasus. While many features cannot be made (friends, achievements, etc.), this means we have a bit more room to play around with the UI.

### Used attributes

This theme makes use of very little information on your games. It attempts to pull data from:

 - `collection.name` and `collection.shortName` for the title up top
 - `game.title` for the main game title
 - `game.developer` to display the developer under the title
 - `game.tile` for the main game image in the bottom list
 - if `game.tile` is not specified, `game.logo` will be tried and overlaid on top of `game.background`
 - `game.screenshots` for the background image, and as a fallback if `game.tile` is not specified

### Usage notes

Due to not having looked up licenses for the assets that are used, these have been excluded from the assets/ folder.
These are used to provide default backgrounds for games that do not have any, as well as a default image for games not having any.
If you want to change, edit, remove or add more of those, have a look at `theme.qml`. The default backgrounds are specified in the `defaultBackgrounds` property.
The theme will attempt to load a `default-tile.jpg` image from the assets folder for items that do not have any. You may disable this in `GameListElement.qml`, in the `source` attribute of `gameListCover`.

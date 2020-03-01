# Scottish Power Test
-

###Points of Discussion

#### Assumptions Made

The project supports Dyanmic type, with self sizing cells, as well as dark mode on iOS 13. I also noticed the wireframes called for non square album art on the list layout and in the details. 

To support dynamic type and a potential for long artist and track titles, I've made the flow handle resizing each cell individually. However it's just a case of changing the custom layout flow in order to make them all a standard size if that's desired. This can also be done by the labels themselves changing the font and number of lines.

I've stuck with this in the details, however in the list, I went for squares as cropping issues would occur and I thought the squares looked better. Obviously in a work environment this would be at the UX teams discression, so I have an easy set of constraints to change the priority on to make the image take up half the cell (as per wireframes).

I also assumed going to Apple music on device is ok, and as such coded around going straight there rather than to a SFSafariViewController. I tried doing it via SafariViewController, but it opens a blank page then redirects to Apple Music app. It seems apple do not allow itunes links for music to be opened on Safari for iOS. 

I've also scaled up album art where I can by downloading a higher resolution from Apple by editing the URL that comes back in their original response. This doesn't always work however so I default do the standard 100x100 size.

#### Things I would take further

The image view that downloads images isn't an ideal solution. I'd want some sort of manager to do these network calls, perhaps even the network manager, and it would be up to this to also deal with the image cache. 

I've not really made use of coordinator pattern here but wanted to show the thinking behind it. I use it in a lot of apps I work on, and although I didn't really bring over anything like replacing, or replacing after certain views in the stack, I think I got a general point across about using coordinators.

As for the spacing, I'm currently working in a team with very strict spacing linting enforced and I've got used to adding a lot more new lines before and after brackets. This isn't necessarily my coding style if I was left to my own devices.

I haven't written any UI tests due to time constraints it would be fairly easy to record some scrolling and tapping on the app for that. 

As for Unit tests. I've unit tested some of the helpers and utilities where appropriate, but haven't gone into unit testing the view controllers or actual network calls. I would've done more but I thought the five hours to make a decent stab at this would've left me without some functionality if I wrote more tests. 
# LCGCardPrinting
A tool to arrange print-and-play cards for LCG games made in Processing 3.
You must provide your own images with bleed.

Credit to 5argon and coldtoes for templates and card back images.
# How to use it
0. Once you pull it, delete all .gitkeep files from each input folder.
1. Place all your custom images into the respective folders for the correct game within the input folder (Arkham cards in 'arkham', LOTR LCG cards in 'lotr', Marvel Champions cards in 'marvel', any small mini-cards in 'minicards')
2. Make sure all card images end with a 1 or a 2. A 1 represents the front of a card while a 2 represents the back of a card. For the front and back to be linked, the card's names must be identical except for the last character (the 1 or 2) ('a' or 'b' work also). If you do not provide a card back, it will be automatically assigned one based on the folder you put it in (player cards only)
3. Run the sketch. Give it a few minutes. You know it will be done by the sketch automatically closing itself.
4. In the /outputs/ folder you will find your outputted cards as sheets as image files.

Cards are automatically rearranged to work with back-to-back printing (at least how it works on my printer, it might be different on yours).
Each outputted page holds 9 cards. Backs are automatically provided based on the input folder. Encounter card backs are not utilized, but can simply be manually assigned via copying and pasting the card back into the right 'input' folder, replacing its name with the front card's name, and appending a '2' to the end (replacing the 1).
Mini-cards are placed in a template that 'converts' them to a regular-sized card. At some point, I would like to use a more optimized template to fit more mini-cards onto one page, but that's on the backburner currently.
If you overload the input folders with a lot of images you may get an OutOfMemory exception. No solution has been found so far, just reduce the inputs at the moment. The output images are very large.

The code is presented as-is. Card back images are copyrighted Fantasy Flight Games and this application is presented for usage of print and play content and custom content only.

boolean isLOTR = false; //<>//

PImage template;
ArrayList<Card> cards;

PImage defaultPlayerBack;
PImage lotrPlayerBack, marvelPlayerBack;
ArrayList<PImage> outputs;
PImage miniCardTemplateOneCard; //convert a minicard to a standard size card
Point miniCardTemplateTopLeft;
int miniCardWidth, miniCardHeight;

ArrayList<Point> frontLayout;
ArrayList<Point> backLayout;

void setup() {
  miniCardTemplateTopLeft = new Point(113, 124);
  miniCardWidth = 596;
  miniCardHeight = 874;

  frontLayout = new ArrayList<Point>();
  frontLayout.add(new Point(154, 169));
  frontLayout.add(new Point(1711, 169));
  frontLayout.add(new Point(3269, 169));
  frontLayout.add(new Point(154, 2399));
  frontLayout.add(new Point(1711, 2399));
  frontLayout.add(new Point(3269, 2399));
  frontLayout.add(new Point(154, 4630));
  frontLayout.add(new Point(1711, 4630));
  frontLayout.add(new Point(3269, 4630));

  backLayout = new ArrayList<Point>();
  backLayout.add(new Point(3269, 169));
  backLayout.add(new Point(1711, 169));
  backLayout.add(new Point(154, 169));
  backLayout.add(new Point(3269, 2399));
  backLayout.add(new Point(1711, 2399));
  backLayout.add(new Point(154, 2399));
  backLayout.add(new Point(3269, 4630));
  backLayout.add(new Point(1711, 4630));
  backLayout.add(new Point(154, 4630));

  cards = new ArrayList<Card>();

  outputs = new ArrayList<PImage>();
  String path = sketchPath();
  template = loadImage(path+"/template.png");
  defaultPlayerBack = loadImage(path+"/CardBacks/_playerback.png");
  lotrPlayerBack = loadImage(path+"/CardBacks/_playerbackLOTR.png");
  marvelPlayerBack = loadImage(path+"/CardBacks/_playerbackMarvel.png");
  miniCardTemplateOneCard = loadImage(path+"/templateMiniOneCard.jpg");

  StringList allfilenames = new StringList();
  allfilenames.append(listFileNames(path+"/inputs/marvel"));
  allfilenames.append(listFileNames(path+"/inputs/lotr"));
  allfilenames.append(listFileNames(path+"/inputs/arkham"));
  allfilenames.append(listFileNames(path+"/inputs/minicards"));
  String[] filenames = allfilenames.toArray();
  printArray(filenames);

  for (int i = 0; i < filenames.length; i++) {
    Card card = new Card();
    String cardFrontPath = filenames[i];
    card.cardFrontPath = cardFrontPath;
    boolean isCardFront = false;
    card.cardFront =  loadImage(cardFrontPath);

    if (filenames[i].contains("inputs/minicards/")) {
      miniCardTemplateOneCard.copy(card.cardFront, 0, 0, miniCardWidth, miniCardHeight, miniCardTemplateTopLeft.x, miniCardTemplateTopLeft.y, miniCardWidth, miniCardHeight);
      card.cardFront = miniCardTemplateOneCard.copy();
    }
    char number = cardFrontPath.charAt(cardFrontPath.length()-5);
    isCardFront = number=='1'||number=='a';
    cardFrontPath = cardFrontPath.substring(0, cardFrontPath.length()-5);
    String cardBackPath;

    if (i+1 < filenames.length) {
      cardBackPath = filenames[i+1];

      card.cardBackPath = cardBackPath;
      cardBackPath=cardBackPath.substring(0, cardBackPath.length()-5);
    } else
      cardBackPath = "last";
    if (cardBackPath.equals(cardFrontPath)) {
      card.cardBack =  loadImage( filenames[i+1]);
      if (filenames[i].contains("inputs/minicards/")) {
        miniCardTemplateOneCard.copy(card.cardBack, 0, 0, miniCardWidth, miniCardHeight, miniCardTemplateTopLeft.x, miniCardTemplateTopLeft.y, miniCardWidth, miniCardHeight);
        card.cardBack = miniCardTemplateOneCard.copy();
      }
    } else {
      if (filenames[i].contains("inputs/arkham/"))
        card.cardBack = defaultPlayerBack.copy();
      else if (filenames[i].contains("inputs/lotr/"))
        card.cardBack = lotrPlayerBack.copy();
      else if (filenames[i].contains("inputs/marvel/"))
        card.cardBack = marvelPlayerBack.copy();

      cardBackPath="DEFAULT";
    }


    if (isCardFront)
      cards.add(card);
  }
  println("cards loaded, now processing");
  if (cards.size()%9!=0) {
    int missingCards = ceil(cards.size()/9);
    missingCards *= 9;
    missingCards = cards.size()-missingCards;
    missingCards = 9-missingCards;
    println("Note: Total cards not divisible by 9! There will be an empty space unless you add "+(missingCards)+" more cards");
  }
  int cardsProcessed = 0;
  int cardsOnThisPage = 1;
  int cardWidth=1558;
  int cardHeight=2221;
  PImage page;
  PImage page2;
  page = template.copy();
  page2 = template.copy();
  do {
    if (cardsOnThisPage==1) {
      page = template.copy();
      page2 = template.copy();
    }
    Card currentCard = cards.get(cardsProcessed);

    page.copy(currentCard.cardFront, 0, 0, cardWidth, cardHeight, frontLayout.get(cardsOnThisPage-1).x, frontLayout.get(cardsOnThisPage-1).y, cardWidth, cardHeight);
    page2.copy(currentCard.cardBack, 0, 0, cardWidth, cardHeight, backLayout.get(cardsOnThisPage-1).x, backLayout.get(cardsOnThisPage-1).y, cardWidth, cardHeight);

    print(cardsProcessed);
    cardsOnThisPage++;
    if (cardsOnThisPage==10) {
      cardsOnThisPage=1;
      outputs.add(page);
      outputs.add(page2);
    }
    cardsProcessed++;
  } while (cardsProcessed < cards.size());

  if (cardsOnThisPage!=1) {
    outputs.add(page);
    outputs.add(page2);
  }
  //} while (cardsProcessed < 9*3);

  for (int i = 0; i < outputs.size(); i++) {
    outputs.get(i).save(path+"/outputs/"+i+".png");
  }
  exit();
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    for (int i = 0; i < names.length; i++) {
      names[i]=dir+"/"+names[i];
    }
    return names;
  } else {
    return null;
  }
}

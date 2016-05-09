Word.destroy_all
Article.destroy_all
User.destroy_all
Tag.destroy_all

tags = [
  "fun",
  "human body",
  "nature",
  "favorites",
  "politic"
]

tags.each do |tag_name|
   tag = Tag.create( name: tag_name )
end

users = [
  User.create( email: "iulia@ex.com", password: "abcd1234" ),
  User.create( email: "glory@ex.com", password: "abcd1234" ),
  User.create( email: "jessica@ex.com", password: "abcd1234" )
]

known_article = {
  title: "Canada's Fort McMurray wildfire 'to double in size'",
  image: "http://ichef.bbci.co.uk/news/520/cpsprodpb/D63A/production/_89624845_032801845-1.jpg",
  source: "http://www.bbc.com/news/world-us-canada-36235175",
  content: %{
  A huge wildfire which devastated the Canadian oil town of Fort McMurray could double in size over the next 24 hours, officials say.
  The blaze now covers an area larger than New York City and is being fanned by winds and feeding on dry vegetation.
  The flames are moving away from the town, most of whose inhabitants have reached safety.
  But many are still stuck north of Fort McMurray and evacuations by road and air are resuming.
  More than 80,000 people were evacuated from the city earlier this week.
  Thousands of people have been airlifted out but a mass convoy evacuating people from oil worker camps in the north was halted on Friday as huge flames flanked the road.
},
tags: "nature, disaster, canada, news"
}

users.each do |user|
  article = Article.create(content:known_article[:content], title:known_article[:title], image:known_article[:image], user: user)
  article.content.split(/\W+/).each do |word|
    word.downcase!
    if Word.where( name:word).where(user:user).exists?
    else
      Word.create(name:word, known:true, user:user)
    end
  end
  known_article[:tags].split(", ").each do |name|
    if tag = Tag.find_by( name: name)
    else
      tag = Tag.create( name: name)
    end
    ArticlesTags.create( tag: tag, article: article )
  end
end





articles = [
  [ "Philippines election: Polls open with outspoken mayor tipped to win",
    "http://ichef-1.bbci.co.uk/news/590/cpsprodpb/530F/production/_89636212_89636079.jpg",
    "http://www.bbc.com/news/world-asia-36244456",
    %{
    People in the Philippines are voting for a new president and other leaders, with outspoken mayor Rodrigo "Digong" Duterte the favourite to win.
    Five candidates are running but Mr Duterte led polls ahead of voting, despite controversial comments while campaigning and a hardline stance.
    The campaign has been driven by public concerns about the economy, inequality and rampant corruption.
    More than 100,000 police officers are on duty amid violence ahead of voting.
    On Monday, seven people were shot dead in an ambush by unknown gunmen in the town of Rosario, in Cavite province, south of the capital, Manila.
    The region had been considered an area of concern because of its political rivalries, said local media.
    On Saturday, a mayoral candidate was murdered in the south of the country.
    President Benigno "Noynoy" Aquino is standing down as the constitution limits presidents to one six-year term. Filipinos will also pick a vice-president and local officials.
    The election campaign has focused on reforming the economy, infrastructure, tackling corruption and crime and on the territorial disputes with China in the South China Sea.
    Mr Duterte has run a campaign focused on law and order issues, but made many controversial statements, including saying that he would butcher criminals.
    A former state prosecutor nicknamed "The Punisher", he has been mayor of the southern city of Davao for more than 22 years.
    He recently joked that, as mayor, he should have been first to rape an Australian missionary murdered in a prison riot, but he later apologised.
    },
    "politic, asia, news"
    ],
  [ "John Oliver Explained Special Districts, SNL Explained Racists for Donald Trump",
    "https://cdn-images-1.medium.com/max/800/0*EoxYi7Zedj1CfHXP.jpg",
    "https://filmschoolrejects.com/john-oliver-explained-special-districts-snl-explained-racists-for-donald-trump-a89a49aace3#.tlvugjuf8",
    %{
    Welcome to Last Night on TV, our daily column that looks back at what happened on television the night before. If we’re going to stay up all night and watch TV, we might as well talk about it the next day.
    In this edition of Last Night on TV, we take a clip walkthrough (clipthrough?) of the weekend in comedy. No, I didn’t watch The Walking Dead. I’m so far behind on The Walking Dead that it’s shameful. Next season. Maybe. Alas, we do have John Oliver and Saturday Night Live rolling with some thoughtful, hilarious political commentary. What else was I supposed to do with my weekend? Watch Daredevil season two and prep a review for later this week? Oh right, I did that, as well. (So stay tuned.)
    Last Week Tonight
    In his big monologue this week, John Oliver took a break from lambasting Donald Trump to explain the small, powerful and insanely under the radar concept of Special Districts:
    Saturday Night Live
    Only a few months after allowing Donald Trump to host one of their episodes, Saturday Night Live finally turned on the Republican Presidential front-runner with a sketch that was cut from this weekend’s show. The political ad spoof features Americans (played by Taran Killam, Vanessa Bayer, Bobby Moynihan, Aidy Bryant, Beck Bennett, and Kyle Mooney) explaining why they support Donald Trump. Some view this as too little, too late for SNL, which basically made a mockery of its show for an entire week pandering to the then joke candidate. But now that Trump’s candidacy has risen from “this is hilarious” to “the seventh seal is opening,” everyone is coming to their senses and going on the attack. Even SNL.
    },
    "trump, elections, usa"
  ]
]


users.each do |user|
  articles.each do |title, image, source, content, tags|
    article = Article.create(content:content, title:title, image:image, user: user)
    article.content.split(/\W+/).each do |word|
      word.downcase!
      if Word.where( name:word).where(user:user).exists?
      else
        Word.create(name:word, known:false, translation:Faker::Hacker.noun, user:user)
      end
    end
    tags.split(", ").each do |name|
      if tag = Tag.find_by( name: name)
      else
        tag = Tag.create( name: name)
      end
      ArticlesTags.create( tag: tag, article: article )
    end
  end
end


new_article =
  { title: "Not OK, Computer",
    image: "https://cdn-images-1.medium.com/max/800/1*rDYag_BX9akyEZ5HnfxiwA.png",
    source: "https://trackchanges.postlight.com/not-ok-computer-35d043463645#.ll9afnowt",
    content: %{
    The middle-aged band Radiohead has mostly erased its Internet presence—Twitter, Facebook, website, etc. Here’s the news (breathless!) from Pitchfork:
    Radiohead’s internet presence is disappearing. As Reddit users noted, their website slowly decreased in opacity until it went entirely blank. It appears that tweets and Facebook posts from their accounts have been steadily disappearing. Update (5/1, 2:00 p.m. ET): There are no longer any tweets or Facebook posts on the band’s accounts. Their profile pictures and cover photos have gone completely blank, as well.
    Which is interesting because Radiohead in times of yore had a pretty great Internet presence. They had this little bear thing and—
    Well, you had to be there. All gone now, but if you visit their site today you’ll see a new video. Maybe it’ll be back some day. Maybe they’re rebooting. Maybe they’ve gone all Marie Kondo on their Internet presence. We all need to simplify as we get older.
    Whether web things should stick around is one of the fundamental tensions of online life. You buy a paper book, you own a book. Unless there’s a flood, it remains readable. You leave it somewhere and it’s there when you come back. But web pages can disappear if you just unplug a wire, or install some new software.
    Back in 1998 (so: between “OK Computer” and “Kid A”), Tim Berners-Lee, the original architect of the WWW, published a web page that is still there, and still unchanged, called “Cool URIs don’t change.” URI stands for “Uniform Resource Identifier”—a web address. And the argument is: If you make a web page and give it an address, it should stay available when someone points to that address. Berners-Lee’s document has a section entitled “Why should I care?” (Every page on the web should have such a section.)
    When you change a URI on your server, you can never completely tell who will have links to the old URI. They might have made links from regular web pages. They might have bookmarked your page. They might have scrawled the URI in the margin of a letter to a friend.
    When someone follows a link and it breaks, they generally lose confidence in the owner of the server. They also are frustrated — emotionally and practically from accomplishing their goal.
    Enough people complain all the time about dangling links that I hope the damage is obvious. I hope it also obvious that the reputation damage is to the maintainer of the server whose document vanished.
    Of course this has not happened. If you browse anything of sufficient age—and this includes Wikipedia—a huge number of the links to the exterior web don’t work, often more than half; this is often called “Linkrot.” The average life span of a web page is, it turns out, 9.3 years. God knows what the average age of a REST call URL or a mobile app view are. Minutes.
    Digital things don’t age well. They get decrepit and stop working. Browsers change, users change, data changes, culture changes. And yet there is something amazing about stumbling across an old URL, one that I designed a decade or more back, and to find it still standing. There’s a real art to naming things
    The one part of the web that I believe is truly genius, and that keeps standing the test of time, is the URI. The Web gave us a way to point to anything, forever. Everything else about the web has changed and grown to encyclopedic lengths, but URIs have been killing it for decades.
    And yet the numbers show we’re hell-bent on screwing all that up with link-shorteners, moving URIs without redirection, and so forth. As always happens in technology we’ve taken a simple idea and found expedient ways to add fragility and complexity to it.
    Designs change, things get relaunched and reskinned, new content management systems come online. It’s nerdy but I take pride when I see a page in the same location ten or fifteen years after it first went up. URIs are the true public interface to ideas on the web, a way to take vast numbers of abstractions and give them reliable, permanent names. Everything in its right place.
    Postlight is growing and hiring. We need product managers, UX designers, and engineers. We ask people to apply through this slightly impersonal form but know that beneath the process we are warm, kind, and inviting souls.
  }}

users.each do |user|
  article = Article.create(title:new_article[:title], content:new_article[:content], image:new_article[:image], user: user)
end

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `hobbies`;
CREATE TABLE `hobbies` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `hobbyName` varchar(80) NOT NULL,
  PRIMARY KEY (`hid`),
);

INSERT INTO `hobbies` (`hid`, `hobbyNamee`) VALUES
(1, 'coding'),
(2, 'reading'),
(3, 'dancing'),
(4, 'gardening'),
(5, 'painting'),
(6, 'exercise');

DROP TABLE IF EXISTS `user_hobbies`;
CREATE TABLE `user_hobbies` (
  `uhid` int(11) NOT NULL AUTO_INCREMENT,
  `hobbyId` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`uhid`),
  FOREIGN KEY (`hobbyId`) REFERENCES Hobbies(`hid`),
  FOREIGN KEY (`username`) REFERENCES Users(`username`)
);

DROP TABLE IF EXISTS `connections`;
CREATE TABLE `connections` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `fromProfile` varchar(100) NOT NULL,
  `toProfile` varchar(100) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cid`),
  FOREIGN KEY (`fromProfile`) REFERENCES Users(`username`),
  FOREIGN KEY (`toProfile`) REFERENCES Users(`username`)
);

INSERT INTO `connections` (`cid`, `fromProfile`, `toProfile`,`date`) VALUES
(3, 'kunjshah45', '111', '2022-04-23 03:01:28'),
(5, 'kunjshah', '111', '2022-04-23 03:01:28'),
(6, 'kunjshah45', 'test1', '2022-04-23 03:01:28'),
(7, 'kunjshah', 'test1', '2022-04-23 03:01:28'),
(8, 'kunjshah45', 'qaz', '2022-04-23 03:01:28'),
(9, 'kunjshah', 'qaz', '2022-04-23 03:01:28'),
(10, 'kunjshah45', '1234', '2022-04-23 03:01:28'),
(11, 'kunjshah', '1234', '2022-04-23 03:01:28');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `email` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `sno` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(99) NOT NULL,
  `author` varchar(100) NOT NULL,
  `tags` varchar(100) NOT NULL,
  `slug` varchar(55) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `views` int(11) DEFAULT NULL,
  PRIMARY KEY (`sno`),
  FOREIGN KEY (`author`) REFERENCES Users(`username`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

INSERT INTO `posts` (`sno`, `title`, `author`,`tags`, `slug`, `content`, `date`, `views`) VALUES
(11, 'It\'s make or break time for artificial intelligence.', 'kunjshah45','blockchain\, bitcoin\, decentralized\, Crypto', 'artificial-intelligence-will-make-or-break-us', '<p>Artificial Intelligence is the next technological frontier, and it has the potential to make or break the world order. The AI revolution could pull the &ldquo;bottom billion&rdquo; out of poverty and transform dysfunctional institutions, or it could entrench injustice and increase inequality. The outcome will depend on how we manage the coming changes.</p>\r\n\r\n<p>Unfortunately, when it comes to managing technological revolutions, humanity has a rather poor track record. Consider the Internet, which has had an enormous impact on societies worldwide, changing how we communicate, work, and occupy ourselves. And it has disrupted some economic sectors, forced changes to long-established business models, and created a few entirely new industries.</p>\r\n\r\n<p>But the Internet has not brought the kind of comprehensive transformation that many anticipated. It certainly didn&rsquo;t resolve the big problems, such as eradicating poverty or <a href=\"https://www.technologyreview.com/s/429690/why-we-cant-solve-big-problems/\" target=\"_blank\">enabling</a> us to reach Mars. As PayPal co-founder Peter Thiel once noted: &ldquo;We wanted flying cars; instead, we got 140 characters.&rdquo;</p>\r\n\r\n<p>In fact, in some ways, the Internet has exacerbated our problems. While it has created opportunities for ordinary people, it has created even more opportunities for the wealthiest and most powerful. A <a href=\"http://www.lse.ac.uk/website-archive/newsAndMedia/news/archives/2016/02/Internet--social-inequalities.aspx\" target=\"_blank\">recent study</a> by researchers at the LSE reveals that the Internet has increased inequality, with educated, high-income people deriving the greatest benefits online and multinational corporations able to grow massively &ndash; while evading accountability.</p>\r\n\r\n<p>Perhaps, though, the AI revolution can deliver the change we need. Already, AI &ndash; which focuses on advancing the cognitive functions of machines so that they can &ldquo;learn&rdquo; on their own &ndash; is reshaping our lives. It has delivered self-driving (though still not flying) cars, as well as virtual personal assistants and even autonomous weapons.</p>\r\n\r\n<p>But this barely scratches the surface of AI&rsquo;s potential, which is likely to produce societal, economic, and political transformations that we cannot yet fully comprehend. AI will not become a new industry; it will penetrate and permanently alter every industry in existence. AI will not change human life; it will change the boundaries and meaning of being human.</p>\r\n\r\n<p>How and when this transformation will happen &ndash; and how to manage its far-reaching effects &ndash; are questions that keep scholars and policymakers up at night. Expectations for the AI era range from visions of paradise, in which all of humanity&rsquo;s problems have been solved, to fears of dystopia, in which our creation becomes an existential threat.</p>\r\n\r\n<p>Making predictions about scientific breakthroughs is notoriously difficult. On September 11, 1933, the famed nuclear physicist Lord Rutherford <a href=\"https://www.technologyreview.com/s/602776/yes-we-are-worried-about-the-existential-risk-of-artificial-intelligence/\" target=\"_blank\">told a large audience</a>, &ldquo;Anyone who looks for a source of power in the transformation of the atoms is talking moonshine.&rdquo; The next morning, Leo Szilard hypothesized the idea of a neutron-induced nuclear chain reaction; soon thereafter, he patented the nuclear reactor.</p>\r\n\r\n<p>The problem, for some, is the assumption that new technological breakthroughs are incomparable to those in the past. Many scholars, pundits, and practitioners would agree with Alphabet Executive Chairman Eric Schmidt that technological phenomena have their own intrinsic properties, which humans &ldquo;don&rsquo;t understand&rdquo; and should not &ldquo;mess with.&rdquo;</p>\r\n\r\n<p>Others may be making the opposite mistake, placing too much stock in historical analogies. The technology writer and researcher <a href=\"https://www.project-syndicate.org/columnist/evgeny-morozov\" target=\"_blank\">Evgeny Morozov</a>, among others, expects some degree of path dependence, with current discourses shaping our thinking about the future of technology, thereby influencing technology&rsquo;s development. Future technologies could subsequently impact our narratives, creating a sort of self-reinforcing loop.</p>\r\n\r\n<p>To think about a technological breakthrough like AI, we must find a balance between these approaches. We must adopt an interdisciplinary perspective, underpinned by an agreed vocabulary and a common conceptual framework. We also need policies that address the interconnections among technology, governance, and ethics. Recent initiatives, such as <a href=\"https://www.partnershiponai.org/\" target=\"_blank\">Partnership on AI</a> or <a href=\"http://www.knightfoundation.org/press/releases/knight-foundation-omidyar-network-and-linkedin-founder-reid-hoffman-create-27-million-fund-to-research-artificial-intelligence-for-the-public-interest\" target=\"_blank\">Ethics and Governance of AI Fund</a> are a step in the right direction, but lack the necessary government involvement.</p>\r\n\r\n<p>These steps are necessary to answer some fundamental questions: What makes humans human? Is it the pursuit of hyper-efficiency &ndash; the &ldquo;Silicon Valley&rdquo; mindset? Or is it irrationality, imperfection, and doubt &ndash; traits beyond the reach of any non-biological entity?</p>\r\n\r\n<p>Only by answering such questions can we determine which values we must protect and preserve in the coming AI age, as we rethink the basic concepts and terms of our social contracts, including the national and international institutions that have allowed inequality and insecurity to proliferate. In a context of far-reaching transformation, brought about by the rise of AI, we may be able to reshape the <em>status quo</em>, so that it ensures greater security and fairness.</p>\r\n\r\n<p>One of the keys to creating a more egalitarian future relates to data. Progress in AI relies on the availability and analysis of large sets of data on human activity, online and offline, to distinguish patterns of behavior that can be used to guide machine behavior and cognition. Empowering all people in the age of AI will require each individual &ndash; not major companies &ndash; to own the data they create.</p>\r\n\r\n<p>With the right approach, we could ensure that AI empowers people on an unprecedented scale. Though abundant historical evidence casts doubt on such an outcome, perhaps doubt is the key. As the late sociologist Zygmunt Bauman put it, &ldquo;questioning the ostensibly unquestionable premises of our way of life is arguably the most urgent of services we owe our fellow humans and ourselves.&rdquo;</p>\r\n', '2022-05-01 03:03:28', 48),
(13, 'A Simple Solution to Poor Office Communication', 'kunjshah45','NFT\, Crypto\, Datbase', 'a-simple-solution-to', 'How about this: Sit everyone down and tell them to stop complaining — they should be jumping for joy that you’re all still in business! Remind them that if they were working harder they wouldn\’t have time to complain. Then end everything in a team cheer (but a fast one, because people need to stop yapping and get back to work).\r\nMore seriously, you’re facing a common problem for companies of your size. Back when you ran a smaller company, there was no need for company-wide emails and meetings to keep people aligned. You all worked in the same room, and spoke daily and company direction could largely be absorbed by the employees through osmosis.\r\nBut now that approach isn’t working. You’ve brought on staff who you’re not necessarily in touch with each day, and they’re saying they don’t understand the bigger picture, or perhaps even what their colleagues in other departments are doing. Meanwhile, your earliest employees aren’t sure what has changed about the initial vision, which continues, rightly or wrongly, to guide their own decision-making.\r\nAt this point you should be doing some kind of company all-hands at least once a month (ideally more frequently than this). You don’t need a fancy PowerPoint presentation or any prepped material (that’s always nice, but let’s be realistic). The point is to get up and give an overview of where the business is, what big highlights (and challenges) you’ve faced over the past month, and where things are headed. You’ve got a roadmap, right? Pull that out and show people how you are tracking. Come back to that roadmap or overall plan again and again.\r\nThis approach is obviously helpful for keeping your team aligned, but it also has other benefits: It’s motivating for people to understand how the company is moving forward, and if you’ve hit a rough patch, it’s helpful for them to understand the roadblocks that are slowing you down.\r\nIf you can swing doing this every week or every two weeks, even better. Even if you’re just giving a five-minute overview, then taking questions, that’s still a valuable half hour of time in which you will manage to hit all your employees in one go. Bonuses: your employees will see you as human; they’ll have a chance to get answers to questions their own manager may not be able to answer; and they are reminded, as they sit and share drinks and snacks with others, that they are part of a bigger team and a grand plan.\r\nThe point is that each team should be giving a snapshot of what they are doing and how it relates to the overall business.\r\nPlay with the structure of your all-hands, and if employees are receptive, see how you can expand the content of the session now and then to help bridge the potential disconnect between different teams. Make your engineering team “own” one all-hands, where they get 10 minutes to present what they are doing. The marketing and communications folks get the following month, and your sales people the next. The content matters, but it doesn’t need to be perfect. The point is that each team should be giving a snapshot of what they are doing and how it relates to the overall business — and just as importantly, giving some guidance as to how they can help or when they should be looped in on something. This is obviously also a great way for people to learn about people outside their departments.\r\nThere are plenty of other things you can look at — for example, company-wide emails to celebrate big successes, a quarterly presentation with updates on the business, and a regular check-in with your non-technical teams to understand their blind spots and broader plans.\r\nOne final note: A retreat doesn’t count. I’ve often been struck by the number of start-ups I know that are great about taking their companies on Napa or Cabo boondoggles, but don’t have basic company-wide meetings in place. Sure, giving your employees a chance to connect at a winery or beach bar is a lot of fun (and full of potential HR infractions!) but it’s not a replacement for ensuring that employees have the information they need to do their jobs. And here’s a bonus: you’re less likely to end up with a lawsuit from a company all-hands than from that boozy winery trip!', '2022-05-01 18:57:24', 8),
(20, 'Food Ordering bot- Building the New Age Restaurant', 'kunjshah','Italian\, chinese\, mexican', 'food-ordering-bot-building-the-new-age-restaurant', '<p>Everyone likes good food. But do you know what&rsquo;s better than good food ? A great food recommendation. With technology entering every sector imaginable, it shouldn&rsquo;t come as a surprise that the new age restaurant will be the one where the waiter/chef will know about your preferences and will provide you with delicious food made just for your taste buds.</p>\r\n\r\n<p>We, at MindIQ, are passionate to help businesses grow by providing them the infrastructure to deliver best customer experiences. And we believe that to deliver the best customer experience, businesses should understand their customers well.</p>\r\n\r\n<p>For a moment, let&rsquo;s visualize the New Age Restaurant. You step in the restaurant, are seated and instead of being handed a menu, the waiter asks you for your preferences. Chinese, Indian, Italian? Starters, Main Course?Spicy, Sweet? You let the waiter know your preferences and after some time, he comes back with food that will blow your tastebuds away. Now that&rsquo;s some customer experience.</p>\r\n\r\n<p>MindIQ makes it easy for businesses to build bots. Think of these bots as the waiter in the New Age Restaurant. The bot will ask questions to know your preferences.</p>\r\n\r\n<p>Either a small restaurant delivering to a nearby community or a big food-tech aggregator- our ChatBot solution will allow your customers to order food through their Facebook Messenger.</p>\r\n\r\n<p>We invite all businesses to give <a href=\"http://mindiq.in/\" target=\"_blank\">MindIQ</a> a try. Businesses don&rsquo;t require any prior programming experience to make a bot. Also, we&rsquo;ve made it so easy and simple that businesses can <a href=\"https://blog.mindiq.in/build-an-ai-powered-chatbot-in-just-7-minutes-57e8a1c0a718\" target=\"_blank\">build a bot in just 5 minutes</a>. (No we&rsquo;re not kidding.)</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2022-05-01 21:03:49', 9),
(21, 'How to Learn to Code and Get Your First Job', 'kunjshah','RandomForest\, SKLearn\, CNN\, RNN', 'learning-to-code-your-first-job', '<p>How I Learned to Code and Got My First Job</p>\r\n\r\n<p>My coding journey began about two and a half years ago, and I started working my first full-time developer job recently (wooo!). This might seem like a long time for some of you, but I didn&#39;t rush it and wasn&#39;t trying to find work until two months ago. Many people have done it more quickly and I was probably ready for a while. So I&#39;ve decided to share my story, my resources, and what worked for me when learning web development.</p>\r\n\r\n<h3>How I got interested in coding</h3>\r\n\r\n<p>I was living in Thailand, training and fighting Muay Thai while working about 10 hours a week as a social media manager. I wasn&#39;t really enjoying marketing as a career and it wasn&#39;t as flexible as I wished, since I needed to be active at certain hours of the day.</p>\r\n\r\n<p>Luckily I had the time to learn something new. I&#39;d looked at a few things online which sounded like good skills to have that were flexible and that could be done remotely. But it wasn&#39;t until I met a guy traveling through Vietnam, who was working as a web developer, that I was intrigued and started to play around a little bit with coding.</p>\r\n\r\n<h3>Where To Learn?</h3>\r\n\r\n<p>At first, I was jumping around trying out different sites such as Codecademy, freeCodeCamp, and others I can&#39;t recall. I never really got anywhere with these to start with but they got me interested.</p>\r\n\r\n<p>After researching, I decided to take CS50 - Introduction To Computer Science, a famous Harvard course run by David Malan. It teaches the real basics of computer science such as data structures, algorithms, and the relevant workings of a computer. This is all done in C but the basics you learn and the confidence you build apply to every language.</p>\r\n\r\n<p>Once I completed CS50 I started on freeCodeCamp. What I loved about freeCodeCamp most was the projects. They give you great ideas to practice and test your skills as you are learning. Once I got through the first couple of sections on HTML/CSS/JavaScript and onto more advanced topics, I didn&#39;t find the lessons thorough enough. So I ditched them for Udemy courses which went more in depth on a topic. Then I could go back and build the freeCodeCamp projects for practice.</p>\r\n\r\n<p>I used this combination of Udemy and freeCodeCamp until I had a solid grasp of HTML, CSS, JavaScript, Node, React, and Redux. I also completed all of the projects on freeCodeCamp except for the data visualisation section using D3.js, as I didn&#39;t find this skill in demand when looking at jobs.</p>\r\n\r\n<h3>What Next?</h3>\r\n\r\n<p>Although I was confident in these skills, I still hadn&#39;t gotten involved in open source except for a couple of tiny pull requests. I simply didn&#39;t know where to get started. Every time I looked at issues I couldn&#39;t see anything interesting. Or those that were interesting had already been claimed by someone else.</p>\r\n\r\n<p>Eventually, I got involved with freeCodeCamp as a contributor. I would recommend just making a habit of checking the issues once a week or so to see if there&#39;s something that you want to help with.</p>\r\n\r\n<p>Along with my work with open source, I also got an internship as a front-end developer focused on React. It wasn&#39;t the ideal internship but it was remote and I learned a lot by working on a codebase someone else had built. I was the only dev on the front-end. This presented it&#39;s own challenges, like being given a problem and being responsible for researching and solving it. In this time, I learned about and implemented internationalisation as well as React Native.</p>\r\n\r\n<h3>Getting the Job</h3>\r\n\r\n<p>I had a strong mix of skills, projects and experience to show off, my r&eacute;sum&eacute; in hand, and a portfolio site promoting my work. I was ready!</p>\r\n\r\n<p>Getting the job was mostly a game of patience. All together it took me 2 months of searching and applying every day to jobs. Most of the time I didn&#39;t hear back. I applied for a lot of jobs which were looking for mid level developers or more experience than I had, which didn&#39;t work out. Most of the jobs I found on job boards were advertised by recruiters and I found these the most fruitful. I often received a call and meeting with recruiters who were impressed by my r&eacute;sum&eacute; and skills and were looking for junior roles for me.</p>\r\n\r\n<p>I was also attending meetups to network and look for jobs. I didn&#39;t find any roles directly, as the companies weren&#39;t looking for juniors. However, I did meet a recruiter at a React meetup whom I grabbed coffee with the next week. He had a role from a company that was open to juniors and this is where I ended up accepting a position.</p>\r\n\r\n<p>The hiring process for this position consisted of a tech test (https://github.com/GlynL/tech-test-prendi), and then an interview where I was actually offered the job at the end. It&#39;s a great small company where I&#39;m working with the senior developer and can bounce ideas and get help when I need it. It&#39;s a full-stack job, I get to use React daily, and I will get the chance to work with a lot of technologies as projects require them.</p>\r\n\r\n<p>When I was interviewing, the thing that people appreciated most was that I had worked on a real application in an internship. Even if I could have done everything in a personal project it proved that I could work on a real world application with other people. I would certainly recommend seeking out internships as this will look great on your r&eacute;sum&eacute; and will be a talking point during interviews.</p>\r\n\r\n<h2>What would I do differently?</h2>\r\n\r\n<p>If I were to do it all over again, there&#39;s a couple of things I would do differently.</p>\r\n\r\n<p>For starters, I would get more involved with open source projects much earlier on. There&#39;s always something you can contribute to a project even if you are still learning HTML and CSS. You may have to be more particular about the issues you pick up but you can definitely help! The skills you gain in navigating a large codebase and working with others are invaluable. And as you learn more you can pick more complex issues to match your skills.</p>\r\n\r\n<p>Secondly, I would also start networking earlier as this might&#39;ve led to securing internships and/or junior positions. If people know you are searching for an opportunity then they will think of you when they have something. Or it&#39;ll at least give you an advantage in the application process as they will know who you are and that you have a genuine interest in the field.</p>\r\n', '2022-02-02 03:59:30', 7),
(22, 'What\'s the Difference Between a Framework and Library?', 'kunjshah45','ejs\, haldlebar\, jinja', 'frameworks-vs-libraries', '<p>Today I want to dive into the difference between a framework and a library. So, let&rsquo;s figure this out together by breaking it down:</p>\r\n\r\n<ul>\r\n	<li><strong>Framework:</strong> By definition, &ldquo;&hellip;provides a standard way to build and deploy applications&rdquo; it is &ldquo;..abstraction in which common code providing generic functionality can be selectively overridden or specialized by user code providing specific functionality..&rdquo; (1). Okay&hellip;so far so good, right? Breaking this definition down and the way I see it &mdash; it an environment for functional code to be written and manipulated by the user.</li>\r\n	<li><strong>Library: </strong>According to Wikipedia, <strong>&ldquo;</strong>is a collection of implementations of behavior, written in terms of a language, that has a well-defined interface by which the behavior is invoked&rdquo; (2). Hmm okay let&rsquo;s see &mdash; so from what I&rsquo;m understanding a library is a set of packaged/compiled code with created with a specific functionalities that might want to be reused throughout the program.</li>\r\n</ul>\r\n\r\n<p>To illustrate the differences between libraries and frameworks, let&rsquo;s look at two important open source solutions for building interactive webpages &mdash; jQuery and AngularJS.</p>\r\n\r\n<p>Prior to 2006, DOM manipulation was messy and error prone. Web developers who wanted any level of interactivity were stuck using decade-old JavaScript APIs which could never have anticipated the needs of Web 2.0. To solve these issues, John Resig released jQuery, a set of beautiful, simple abstractions for examining and updating the DOM. Suddenly, tasks that once required many lines of code could now be accomplished in a single line.</p>\r\n\r\n<p>Importantly, jQuery had no requirements for how, when, or where it was used. It could be immediately incorporated into any webpage, without the need to modify existing code. It is effectively just a shorthand notation for executing common JavaScript patterns. This is what makes it a library, rather than a framework.</p>\r\n\r\n<p>Fast forward another decade to 2017: web development is going through a similar transformation with the emergence of MV* frameworks such as React and AngularJS. Like jQuery, they offer huge, time-saving abstractions for DOM manipulation. But unlike jQuery, they can&rsquo;t be seamlessly incorporated into an existing project &mdash; as frameworks, they mandate how your code is structured and run.</p>\r\n\r\n<p>For instance, one of the most useful abstractions in AngularJS is data binding &mdash; tying the value of some variable to what the user types:</p>\r\n\r\n<p>This code automatically updates the &ldquo;Your name is&hellip;&rdquo; message as the user types, which would have previously required dozens of lines of vanilla JavaScript or several lines of jQuery. With AngularJS it&rsquo;s achieved without any logic at all &mdash; just an HTML template!</p>\r\n\r\n<p>The catch is that we can&rsquo;t just add a &lt;script&gt; tag that pulls in AngularJS and start writing templates like this. The HTML needs to be part of an AngularJS component, which will parse it and generate the code we otherwise would have had to write ourselves. In truth, this minimal example requires dozens of lines of additional boilerplate before it will work.</p>\r\n\r\n<h3>Libraries and Frameworks at DataFire</h3>\r\n\r\n<p>With <a href=\"https://datafire.io\" target=\"_blank\">DataFire</a>, our mission is to make your data easily accessible, no matter where it lives or what you want to do with it. We provide open-source integrations for over 500 different services, such as Slack, GitHub, and MongoDB, as well as a command-line tool for connecting them. But is it a library or a framework?</p>\r\n\r\n<p>The answer is both. For each service we connect to, we provide a client library, available on npm. For instance, you can install the Reddit RSS library like this: npm install @datafire/reddit_rss</p>\r\n\r\n<p>And then use it in JavaScript:</p>\r\n\r\n<p>Just like jQuery, you can use this anywhere you want Reddit data. Each of the 500+ DataFire clients can be incorporated into an existing codebase without modification.</p>\r\n\r\n<p>But DataFire also <a href=\"https://github.com/DataFire/DataFire\" target=\"_blank\">provides a framework</a> &mdash; a set of high-level abstractions for building, connecting, and triggering actions. If you&rsquo;re looking to build an API or sync data between two services, the DataFire framework can help.</p>\r\n\r\n<p>To use it, you need to install the DataFire command-line tool:</p>\r\n\r\n<pre>\r\nnpm install -g datafire</pre>\r\n\r\n<h3>Conclusion: Tradeoffs and Control</h3>\r\n\r\n<p>There is a clear tradeoff when deciding whether you should be providing a library or a framework, and it all comes down to control.</p>\r\n\r\n<p>Libraries offer the user a large amount of control, and have a low barrier to entry. They can be seamlessly incorporated into existing projects to add new functionality, and generally require little learning and boilerplate code to get started.</p>\r\n\r\n<p>Frameworks are more powerful, but mandate how users organize their code. They are more likely to be used when starting a new project rather than incorporated into an existing codebase, and the developer will need to learn about the framework&rsquo;s core concepts before they can start using it productively. But this inversion of control also helps developers avoid common errors, inefficiencies, and <a href=\"https://en.wiktionary.org/wiki/bikeshedding\" target=\"_blank\">bikeshedding</a>.</p>\r\n\r\n<p>Overall, frameworks are more opinionated and libraries are more flexible. Both patterns of abstraction have their place in the world of programming, and while neither is inherently better, it&rsquo;s important to determine which is appropriate for the problem you&rsquo;re solving.</p>\r\n\r\n<p>Thank You.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2022-02-02 04:43:00', 18);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,  
  `message` varchar(550) NOT NULL,
  `postid` int(11) NOT NULL,
  `commentdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `commentType` boolean NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `postid` (`postid`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--
INSERT INTO `comments` (`cid`, `username`, `message`, `postid`, `commentdate`, `commentType`) VALUES
(13, 'kunjshah', 'Yeah, I\'m kind of agree with this post. ', 11, '2022-04-02 11:26:03', 1),
(14, 'kunjshah', 'I\'m glad that I came across such posts. It\'s life changer for me.', 13, '2022-04-04 11:31:23',1),
(11, 'kunjshah', 'This is inspiring story. I would love to hear more. Thanks', 21, '2022-02-04 22:14:49', 1),
(12, 'kunjshah45', 'I\'m impressed by the quality of this article. It\'s great.', 11, '2022-02-04 22:24:21', 0),
(10, 'kunjshah45', 'hey this is just amazing content', 21, '2022-04-04 22:10:57', 0),
(15, 'kunjshah45', 'I prefer framework over library but React is really amazing library.', 22, '2022-04-04 16:29:28', 0);

-- --------------------------------------------------------

COMMIT;

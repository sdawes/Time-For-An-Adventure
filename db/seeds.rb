adventure = "The midnight train to Bristol"

synopsis = "Another deeper look in Steve's mind"

chapters = ["The midnight train. You received the letter late - “meet at Paddington Train Station and catch the 23:59 train to Bristol. Stay sober”. You find your way to platform 8, the station is deserted.",

            "The quiet coach. Upon boarding, you take a seat in A24, a window seat. After 30 mins, the train arrives at Reading. You look out of the window to see a man beckoning you to disembark.",

            "The saloon. It is busy in the bar, with late night revellers returning to Bristol. You feel stressed out and really need a drink.",

            "Reading Station. Upon disembarking, the train pulls away from the station. You approach the man. He mutters something incomprehensible, waving a big issue at you. FAIL The man turns out to be nothing more than a big issue seller. You instructions specifically said to board the train to Bristol, you missed the last train there.",

            "Bristol Temple Meads. After an uneventful and speedy journey, you arrive in Bristol at approx 1:50AM. You leave the station and walk out into the beautiful 18th century Brunel courtyard. Upon re-reading the note, you realise there are some symbols at the bottom. BS34JJ33. What could this mean?",

            "A cool drink of lemonade. This is exactly what you needed. You feel refreshed and try to relax as the train ploughs onwards through the stunning wiltshire countryside (not that you can see it as it is past midnight now). Finally, after a couple of hours, the train arrives in Bristol Temple Meads. You exit the station and suddenly see for the first time, a series of letters at the bottom of the note. BS34JJ33.",

            "Red Stripe. The beer tastes good, cold and refreshing. After a few minutes however, you feel strangely dizzy. You can’t breathe. You can see people staring at you, laughing at you, as you’re world turns to dust and begins to fade. FAIL The beer turns out to have been poisoned. Your instructions specifically said to remain sober. This was a hint! ",

            "Navy Blue Cabs. The blue cab driver has worked in Bristol for 25 years and knows the area well. He immediately realises the code is a post code BS3 4JJ and 33 is the number of a house - his old house! 33 Dean Lane. Bemused, the driver drops you off at no 33, Dean Lane. “What could this mean?”, asks the driver. “No fucking idea”, you reply. You pay him a very reasonable £10 and get out of the taxi. When you reach the gate of 33 Dean Lane, you suddenly feel cautious and uneasy. You look behind you and see a man in a black hoodie staring straight back. He turns around and walks off down towards the river.",

            "Reasons Uber are shit. The driver has no experience driving taxis and has no local knowledge. He drives for hours, getting completely lost and it gets hotter and hotter. You open your window and the note blows out of it, into the River Avon. FAIL Without the note, you can not continue on your adventure, as there is further secret information on the note that you had not noticed at the point it flew out of the window. ",

            "No 33 Dean Lane. You notice the door is open, when you go inside, you enter a beautiful victorian terrace, typical of that area of Bristol. You notice a pungent smell coming from the sitting room. When you open the door the smell gets worse OMFG, WHAT IS THAT AHHHHHHHHHH! FAIL You were too overcome to notice the smell, nor did you notice the small blonde haired guy called Steve come running out from behind the table shouting “YOU WONT TAKE MY JOB …. “ but you did notice the flash of what appeared to be a baseball bat, coming towards your head. ",

            "The man with the hooded jacket. You catch up with the man, taking in the sights of the beautiful Bristol harbour, and say to him “Why the fuck are you following me! What do you want!”. He says “calm down, I have something to tell you...” WIN!! The man had an important message to give you in person - congratulations, you have been given a job as a web developer in Bristol! Your dream has come true! "]


choices = ["Board coach A - the quiet coach.",
           "Board coach E - the saloon coach.",
           "Disembark the train.",
           "Ignore the man and remain onboard.",
           "Buy a lemonade.",
           "Buy a can of red stripe.",
           "Hail a blue cab and ask him to take you to where he thinks BS34JJ33 is.",
           "Order an Uber and ask the driver to take you to where he thinks BS34JJ33 is.",
           "Walk through the gate and knock on the door of Number 33 Dean Lane.",
           "Follow the man towards the river."]


Adventure.create(title: adventure, synopsis: synopsis, image: Rack::Test::UploadedFile.new(Rails.root + 'app/assets/images/Bristol.jpeg', 'image/jpeg'))


chapters.each do |chapter|
  adventure = Adventure.where(title: "The midnight train to Bristol").first
  Chapter.create(description: chapter, adventure_id: adventure.id )
end

Choice.create(option: choices[0], resulting_chapter_id: 2, chapter_id: 1)
Choice.create(option: choices[1], resulting_chapter_id: 3, chapter_id: 1)
Choice.create(option: choices[2], resulting_chapter_id: 4, chapter_id: 2)
Choice.create(option: choices[3], resulting_chapter_id: 5, chapter_id: 2)
Choice.create(option: choices[4], resulting_chapter_id: 6, chapter_id: 3)
Choice.create(option: choices[5], resulting_chapter_id: 7, chapter_id: 3)
Choice.create(option: choices[6], resulting_chapter_id: 8, chapter_id: 5)
Choice.create(option: choices[6], resulting_chapter_id: 8, chapter_id: 6)
Choice.create(option: choices[7], resulting_chapter_id: 9, chapter_id: 5)
Choice.create(option: choices[7], resulting_chapter_id: 9, chapter_id: 6)
Choice.create(option: choices[8], resulting_chapter_id: 10, chapter_id: 8)
Choice.create(option: choices[9], resulting_chapter_id: 11, chapter_id: 8)

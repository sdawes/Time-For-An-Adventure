adventures = ["Makers", "Trip to Bristol"]

adventures.each do |adventure|
  Adventure.create(title: adventure)
end

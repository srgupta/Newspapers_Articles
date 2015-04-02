require 'faker'


#REQUIREMENTS (USER STORY):
# Newspaper
  #A newspaper is its own object
  #attributes of a newspaper include the date, headline, and name
  # newspaper with 22 articles
  # tell me total number of words in newspaper
  #tell me the average number of words per article
  #give me a list of all articles with an author whose name contains "Tom"

# Article
  #an article is also its own object
  #attributes of an article include title, author, text
  #tell me the number of words in an article


class Newspaper
  attr_accessor :articles
  attr_reader :number_of_articles
  def initialize(args)
    @date = args[:date]
    @headline = args[:headline]
    @name = args[:name]
    @number_of_articles = args[:number_of_articles] || 22
    @articles = generate_sunday_paper
  end

  def generate_sunday_paper
      # Faker::Lorem.paragraphs(3).join("\n")
      # Faker::Name.name
      articles = []
      # number_of_articles = 22
      number_of_articles.times do
        articles << Article.new({title: 'Man on Moon', author: Faker::Name.name, text: Faker::Lorem.paragraphs(3).join("\n")})
      end
      return articles
    end

  def total_words
    word_count = 0
    articles.each do |article|
      word_count += article.text.split(' ').count
    end
    return word_count
  end

  def average_words_per_article
    total_words / number_of_articles
  end

  def articles_by(name)
    articles_by_author = []
    articles.each do |article|
      # p article.author
      if (article.author =~ /#{name}/)
        articles_by_author << article.author
      end
    end
    return articles_by_author
  end
end


class Article
  attr_reader :text, :author
  def initialize(args)
    @title = args[:title]
    @author = args[:author]
    @text = args[:text]
  end

  def words
    text.split(' ').count
  end
end



#DRIVER CODE:
paper = Newspaper.new({date: '10/10/10', headline: 'Hello', name: 'Chicago Tribune'})
p paper
# p paper = generate_sunday_paper
p paper.total_words
# p paper.articles.length
p paper.number_of_articles

# p paper.articles[0]
p paper.articles[0].words # after this refactor
p paper.average_words_per_article

p paper.articles_by('Mr') # Should match "Mr. Tom", "Tom Kerry", "Tom Bigger" "Tom Smaller"
p paper.articles_by('Mrs').length

#QUESTIONS/Refactors to consider:
#1. makes sense to have generate_sunday_paper in initialize?
#2. what dependencies does can we remove or improve on?
#3. methods to make private?
#4. If used TDD, what Rspec would want?

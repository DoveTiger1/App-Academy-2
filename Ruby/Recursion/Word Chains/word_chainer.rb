class WordChainer
    def initialize(filename)
        file = File.read(filename)
        @dictionary = file.split("\n")
    end

    def adjacentwords(word)
        array = @dictionary.select {|element| adjacent_word(element, word)}
    end

    def adjacent_word(word_1, word_2)
        return false if word_1.length != word_2.length || word_1 == word_2
        count = 0
        word_1.each_char.with_index do |char, index|
            count += 1 if char != word_2[index]
        end
        return count > 1 ? false : true
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}
        until @current_words.empty? || @all_seen_words.has_key?(target)
            explore_current_words
        end

        build_path(target)
    end

    def build_path(target)
        path = []
        until target == nil
            path << target
            target = @all_seen_words[target]
        end
        path.reverse
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacentwords(current_word).each do |adjacent_word|
                next if @all_seen_words.include?(adjacent_word)
                new_current_words << adjacent_word
                @all_seen_words[adjacent_word] = current_word
            end
        end
        @current_words = new_current_words
    end
end

if __FILE__ == $PROGRAM_NAME
    wordchainer = WordChainer.new('dictionary.txt')
    p wordchainer.run('reuse', 'donor')
end
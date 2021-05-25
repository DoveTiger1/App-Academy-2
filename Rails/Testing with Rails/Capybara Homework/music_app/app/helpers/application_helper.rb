module ApplicationHelper

    def auth_token
        "<input type='hidden' name='authenticity_token'
        value=#{form_authenticity_token}>".html_safe
    end

    def ugly_lyrics(lyrics)
        pretty_lyrics = ""

        lyrics.each_line do |line|
            if line.match(/^[\s]*$\n/)
                pretty_lyrics << line
            else
                pretty_lyrics << ("&#9835; " + line)
            end
        end

        "<pre>#{pretty_lyrics}
        </pre>".html_safe
    end
    
end

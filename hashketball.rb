require "pry"

def game_hash 
  {
     :away => { :team_name => "Charlotte Hornets",
                :colors => ["Turquoise", "Purple"],
                :players => [
                  {:player_name => "Jeff Adrien",
                   :number => 4,
                   :shoe => 18,
                   :points => 10,
                   :rebounds => 1,
                   :assists => 1,
                   :steals => 2,
                   :blocks => 7,
                   :slam_dunks => 2
                  },
                  {:player_name => "Bismack Biyombo",
                   :number => 0,
                   :shoe => 16,
                   :points => 12,
                   :rebounds => 4,
                   :assists => 7,
                   :steals => 22,
                   :blocks => 15,
                   :slam_dunks => 10
                  },
                  {:player_name => "DeSagna Diop",
                   :number => 2,
                   :shoe => 14,
                   :points => 24,
                   :rebounds => 12,
                   :assists => 12,
                   :steals => 4,
                   :blocks => 5,
                   :slam_dunks => 5
                  },
                  {:player_name => "Ben Gordon",
                   :number => 8,
                   :shoe => 15,
                   :points => 33,
                   :rebounds => 3,
                   :assists => 2,
                   :steals => 1,
                   :blocks => 1,
                   :slam_dunks => 0
                  },
                  {:player_name => "Kemba Walker",
                   :number => 33,
                   :shoe => 15,
                   :points => 6,
                   :rebounds => 12,
                   :assists => 12,
                   :steals => 7,
                   :blocks => 5,
                   :slam_dunks => 12
                  }
                ]
             },
     :home => { :team_name => "Brooklyn Nets",
                :colors => ["Black", "White"],
                :players => [
                  {:player_name => "Alan Anderson",
                   :number => 0,
                   :shoe => 16,
                   :points => 22,
                   :rebounds => 12,
                   :assists => 12,
                   :steals => 3,
                   :blocks => 1,
                   :slam_dunks => 1
                  },
                  {:player_name => "Reggie Evans",
                   :number => 30,
                   :shoe => 14,
                   :points => 12,
                   :rebounds => 12,
                   :assists => 12,
                   :steals => 12,
                   :blocks => 12,
                   :slam_dunks => 7
                  },
                  {:player_name => "Brook Lopez",
                   :number => 11,
                   :shoe => 17,
                   :points => 17,
                   :rebounds => 19,
                   :assists => 10,
                   :steals => 3,
                   :blocks => 1,
                   :slam_dunks => 15
                  },
                  {:player_name => "Mason Plumlee",
                   :number => 1,
                   :shoe => 19,
                   :points => 26,
                   :rebounds => 11,
                   :assists => 6,
                   :steals => 3,
                   :blocks => 8,
                   :slam_dunks => 5
                  },
                  {:player_name => "Jason Terry",
                   :number => 31,
                   :shoe => 15,
                   :points => 19,
                   :rebounds => 2,
                   :assists => 2,
                   :steals => 4,
                   :blocks => 11,
                   :slam_dunks => 1
                  }
                ]
     }
   }
end

def num_points_scored(name)
  points_made=nil
  game_hash.each do |home_or_away, team|
    team.each do |key, value|
      if key == :players

      value.each do |player|
        if player[:player_name] == name
          points_made = player[:points]
      end
    end
    end
    end
  end
  points_made
end
    
def shoe_size(name)
  shoe_sizez=nil
  game_hash.each do |home_or_away, team|
    team.each do |key, value|
      if key == :players

      value.each do |player|
        if player[:player_name] == name
          shoe_sizez = player[:shoe]
      end
    end
    end
    end
  end
  shoe_sizez
end

def team_colors(name)
  colors = []
  game_hash.each do |home_or_away, team|
    if team[:team_name] == name
       colors = game_hash[home_or_away][:colors]
     end
  end
  colors
end

def team_names
  game_hash.map do |home_or_away, team|
    team[:team_name]
  end
end

def player_numbers (name)
  numbers = []
  game_hash.each do |home_or_away, team|
    if team[:team_name] == name

    team.each do |key, value|
       if key == :players

      value.each do |memo|
        numbers.push(memo[:number])
      end
      end
      end
    end
  end
  numbers
end

def player_stats(name)
  stats_hash = {}
  game_hash.collect do |home_or_away, team|
    team.each do |key, value|
      if key == :players

      game_hash[home_or_away][key].each do |memo|
        if memo[:player_name] == name

        stats_hash = memo.delete_if do |k,v|
          k == :player_name
        end
      end
      end
      end
    end
  end
  stats_hash
end

def big_shoe_rebounds 
  biggest_foot = 0 
  most_boards = 0 
  game_hash.each do |home_or_away,team|
    team[:players].each do |player|
      if player[:shoe] > biggest_foot
        biggest_foot = player[:shoe]
        most_boards = player[:rebounds]
      end
    end
  end
  most_boards
end


def find_player_stat(name, stat)
  game_hash.each do |home_or_away, team|
    team[:players].each do |player|
      return player[stat] if player[:player_name] == name
    end
  end
end

def find_player_with_most(stat_category)
  name = "Me"
  most_stat = 0

  game_hash.each do |home_or_away, team|
    team[:players].each do |player|
      if player[stat_category].is_a? String
        if player[stat_category].length > most_stat
          most_stat = player[stat_category].length
          name = player[:player_name]
        end
      elsif player[stat_category] > most_stat
        most_stat = player[stat_category]
        name = player[:player_name]
      end
    end
  end
  name
end

def most_points_scored
  find_player_with_most(:points)
end

def winning_team
  team_points = { 'Brooklyn Nets' => 0, 'Charlotte Hornets' => 0 }

  game_hash.each do |home_or_away, team|
    team[:players].each do |player|
      team_points[team][:team_name] = team_points[team][:team_name] + find_player_stat(player[:player_name], :points)
    end
  end
  team_points.max_by { |key, value| value }
end

def player_with_longest_name
  find_player_with_most(:player_name)
end

def long_name_steals_a_ton?
  find_player_with_most(:steals) == find_player_with_most(:player_name)
end
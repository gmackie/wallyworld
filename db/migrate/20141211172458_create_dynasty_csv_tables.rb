class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :season_number
      t.integer :week_number
      t.string :poll_name
      t.integer :rank
      t.integer :previous_rank
      t.integer :wins
      t.integer :losses
      t.float :fpv
      t.integer :points
    end
  end
end

class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.integer :season_number
      t.string :first_name
      t.string :last_name
      t.integer :caliber
      t.string :status
      t.string :height
      t.string :position
      t.integer :weight
      t.integer :rank
      t.string :hometown
      t.integer :speed_base
      t.integer :strength_base
      t.integer :agility_base
      t.integer :acceleration_base
      t.integer :jumping_base
      t.integer :awareness_base
      t.integer :stamina_base
      t.integer :injury_base
      t.integer :break_tackle_rushing
      t.integer :trucking_rushing
      t.integer :elusiveness_rushing
      t.integer :stiff_arm_rushing
      t.integer :spin_move_rushing
      t.integer :juke_move_rushing
      t.integer :carrying_rushing
      t.integer :pass_block_blocking
      t.integer :run_block_blocking
      t.integer :impact_blocking_blocking
      t.integer :catching_receiving
      t.integer :spectacular_catch_receiving
      t.integer :catch_in_traffic_receiving
      t.integer :route_running_receiving
      t.integer :release_receiving
      t.integer :tackle_tackling
      t.integer :hit_power_tackling
      t.integer :pursuit_tackling
      t.integer :play_recognition_tackling
      t.integer :power_moves_blockingshedding
      t.integer :finesse_moves_blockingshedding
      t.integer :block_shedding_blockingshedding
      t.integer :man_coverage_coverage
      t.integer :zone_coverage_coverage
      t.integer :press_coverage
      t.integer :throw_power_passing
      t.integer :throw_accuracy_passing
      t.integer :kick_power_kicking
      t.integer :kick_accuracy_kicking
      t.string :school_1
      t.string :school_2
      t.string :school_3
      t.string :school_4
      t.string :school_5
      t.string :school_6
      t.string :school_7
      t.string :school_8
      t.string :school_9
      t.string :school_10
    end
  end
end

class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :week_number
      t.integer :season_number
      t.integer :broadcast
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_score
      t.integer :away_score
      t.integer :winner_id
      t.integer :loser_id
      t.integer :q1_home
      t.integer :q1_away
      t.integer :q2_home
      t.integer :q2_away
      t.integer :q3_home
      t.integer :q3_away
      t.integer :q4_home
      t.integer :q4_away
      t.integer :ot_home
      t.integer :ot_away
    end
  end
end

class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :season_number
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :year
      t.integer :overall
      t.string :hometown
      t.integer :attempts
      t.integer :completion
      t.integer :interception
      t.integer :touch_downs
      t.integer :yards
      t.integer :fumbles
      t.integer :long
      t.integer :catches
      t.string :team
      t.integer :fga
      t.integer :fgs
      t.integer :points
      t.integer :xpa
      t.integer :xpm
      t.integer :ff
      t.integer :fr
      t.integer :sacks
      t.integer :tackles_for_loss
      t.integer :tackles
      t.integer :speed
      t.integer :strength
      t.integer :agility
      t.integer :acceleration
      t.integer :jumping
      t.integer :awareness
      t.integer :stamina
      t.integer :injury
      t.integer :break_tackle
      t.integer :trucking
      t.integer :elusiveness
      t.integer :stif_farm
      t.integer :spin_move
      t.integer :juke_move
      t.integer :carrying
      t.integer :ball_carrier_vision
      t.integer :pass_block
      t.integer :run_block
      t.integer :catching
      t.integer :spectacular_catch
      t.integer :catch_in_traffic
      t.integer :route_running
      t.integer :release
      t.integer :tackle
      t.integer :hit_power
      t.integer :pursuit
      t.integer :play_recognition
      t.integer :power_moves
      t.integer :finesse_moves
      t.integer :block_shedding
      t.integer :man_coverage
      t.integer :zone_coverage
      t.integer :press
      t.integer :throw_power
      t.integer :throw_accuracy
      t.integer :kick_power
      t.integer :kick_accuracy
    end
  end
end

class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :conference
      t.string :coach_id
      t.string :conference_record
      t.integer :conference_standing
      t.integer :division_standing
      t.integer :wins
      t.integer :losses
      t.integer :pointsagainst
      t.integer :pointsfor
      t.float :winpercent
    end
  end
end

class AddDynastyToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer wins
      t.integer losses
      t.integer active_dynasties
      t.integer seasons_completed
      t.integer access_level
      t.boolean played_game
      t.integer recruiting_points
      t.boolean auto_pilot
    end
    add_reference :dynasties, :user, index: true
    add_reference :teams, :dynasty, index: true
    add_reference :players, :dynasty, index: true
    add_reference :players, :team, index: true
    add_reference :prospects, :dynasty, index: true
    add_reference :games, :dynasty, index: true
    add_reference :rankings, :dynasty, index: true
    add_reference :teams, :user, index: true
  end
end

class CreateDynasties < ActiveRecord::Migration
  def change
    create_table :dynasties do |t|
      t.integer :owner_id
      t.string :name
      t.integer :week_number
      t.integer :season_number
    end
  end
end

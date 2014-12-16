require 'csv'

class CsvImportsController < ApplicationController
  
  def index

  end

  def show

  end

  def self.csv_path(csv_string, report_string)
    return "/home/mackieg/Downloads/dynasty/" + report_string + "_" + csv_string + ".csv"
  end

  def self.import_csvs
    #dynasty = params[:dynasty_id]
    #season = params[:season_num]
    #week = params[:week_num]
    #csv_string = params[:csv_string]
    dynasty = 1
    season = 2
    week = 10
    csv_string = "Hacksaw8DU2015"
    first_import = true
    prospect_csv = csv_path(csv_string,  "Prospects")
    player_roster_csv = csv_path(csv_string,  "TeamRoster")
    game_csv = csv_path(csv_string,  "Schedule")
    player_stats_csv = csv_path(csv_string,  "Stats")
    ranking_csv = csv_path(csv_string,  "PollRankings")

    if (week == 0 || first_import)
      import_teams(season, dynasty, csv_path(csv_string,"TeamStandings"))
      import_prospects(season, dynasty, prospect_csv)
      import_players(season, dynasty, player_roster_csv)
    end
  
    import_games(season, dynasty, week, game_csv)
    import_rankings(season, dynasty, week, ranking_csv)
    update_players_stats(season, dynasty, player_stats_csv)
  end
  
  def self.import_teams(season, dynasty, csv_upload)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      record = row["overallRec"].split('-')
      wins = record[0]
      losses = record[1]
      team = Team.create(
        dynasty_id: dynasty,
        season_number: season, 
        name: row["TeamName"],
        conference_record: row["confRec"],
        conference_standing: row["confStanding"],
        division_standing: row["divStanding"],
        wins: wins,
        losses: losses,
        pointsagainst: row["pointsAgainst"],
        pointsfor: row["pointsFor"],
        winpercent: row["winPercent"]
      )
    end
  end
  
  def self.import_rankings(season, dynasty, week, csv_upload)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      team_id = Team.find_by_name(row["TeamName"]).id
      Ranking.create(
        dynasty_id: dynasty,
        season_number: season,
        week_number: week,
        team_id: team_id,
        poll_name: row["PollName"],
        rank: row["Rank"],
        previous_rank: row["PreviousRank"],
        wins: row["Wins"],
        losses: row["Losses"],
        fpv: row["FPV"],
        points: row["Points"],
      )
    end
  end
  
  def self.import_prospects(season, dynasty, csv_upload)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      player_name = row["Name"].split(" ")
      first_name  = player_name[0]
      last_name   = player_name[1]
      Prospect.create(
        dynasty_id: dynasty,
        season_number: season,
        first_name: first_name,                        
        last_name: last_name,                        
        caliber: row["Caliber"],                          
        status: row["status"],                           
        height: row["Height"],                           
        position: row["position"],                         
        weight: row["weight"],                           
        rank: row["rank"],                             
        hometown: row["homeTown"],                         
        speed_base: row["Speed(base)"],                      
        strength_base: row["Strength(base)"],                   
        agility_base: row["Agility(base)"],                    
        acceleration_base: row["Acceleration(base)"],               
        jumping_base: row["Jumping(base)"],                    
        awareness_base: row["Awareness(base)"],                  
        stamina_base: row["Stamina(base)"],                    
        injury_base: row["Injury(base)"],                     
        break_tackle_rushing: row["Break Tackle(rushing)"],            
        trucking_rushing: row["Trucking(rushing)"],                
        elusiveness_rushing: row["Elusiveness(rushing)"],             
        stiff_arm_rushing: row["Stiff Arm(rushing)"],               
        spin_move_rushing: row["Spin Move(rushing)"],               
        juke_move_rushing: row["Juke Move(rushing)"],               
        carrying_rushing: row["Carrying(rushing)"],                
        pass_block_blocking: row["Pass Block(blocking)"],             
        run_block_blocking: row["Run Block(blocking)"],              
        impact_blocking_blocking: row["Impact Blocking(blocking)"],        
        catching_receiving: row["Catching(receiving)"],              
        spectacular_catch_receiving: row["Spectacular Catch(receiving)"],     
        catch_in_traffic_receiving: row["Catch In Traffic(receiving)"],      
        route_running_receiving: row["Route Running(receiving)"],         
        release_receiving: row["Release(receiving)"],               
        tackle_tackling: row["Tackle(tackling)"],                 
        hit_power_tackling: row["Hit Power(tackling)"],              
        pursuit_tackling: row["Pursuit(tackling)"],                
        play_recognition_tackling: row["Play Recognition(tackling)"],       
        power_moves_blockingshedding: row["Power Moves(blockingShedding)"],    
        finesse_moves_blockingshedding: row["Finesse Moves(blockingShedding)"],  
        block_shedding_blockingshedding: row["Block Shedding(blockingShedding)"], 
        man_coverage_coverage: row["Man Coverage(coverage)"],           
        zone_coverage_coverage: row["Zone Coverage(coverage)"],          
        press_coverage: row["Press(coverage)"],                  
        throw_power_passing: row["Throw Power(passing)"],             
        throw_accuracy_passing: row["Throw Accuracy(passing)"],          
        kick_power_kicking: row["Kick Power(kicking)"],              
        kick_accuracy_kicking: row["Kick Accuracy(kicking)"],           
        school_1: row["School 1"],
        school_2: row["School 2"],
        school_3: row["School 3"],
        school_4: row["School 4"],
        school_5: row["School 5"],
        school_6: row["School 6"],
        school_7: row["School 7"],
        school_8: row["School 8"],
        school_9: row["School 9"],
        school_10: row["School 10"]
      )
    end
  end
  
  def self.import_games(season, dynasty, week, csv_upload)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      home_team_id = Team.find_by_name(row["HomeTeam"]).id
      # nil id if we play FCS teams...
      away_team_id = Team.find_by_name(row["AwayTeam"]).id unless Team.find_by_name(row["AwayTeam"]).nil? 
      week_arr = row["WeekNum"].split(' ')
      winner_id = (row["HomeScore"] > row["AwayScore"]) ? home_team_id : away_team_id
      loser_id  = (row["HomeScore"] < row["AwayScore"]) ? home_team_id : away_team_id
      Game.create(
        dynasty_id: dynasty,
        season_number: season,
        week_number: week_arr[1].to_i,
        home_team_id: home_team_id,
        away_team_id: away_team_id,
        home_score: row["HomeScore"],
        away_score: row["AwayScore"],
        winner_id: winner_id,
        loser_id: loser_id,
        q1_home: row["Q1Home"],
        q1_away: row["Q1Away"],
        q2_home: row["Q2Home"],
        q2_away: row["Q2Away"],
        q3_home: row["Q3Home"],
        q3_away: row["Q3Away"],
        q4_home: row["Q4Home"],
        q4_away: row["Q4Away"],
        ot_home: row["OTHome"],
        ot_away: row["OTAway"]
      )
    end
  end
  
  def self.import_players(dynasty, season, csv_upload)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      team_id = Team.find_by_name(row["TeamName"])
      Player.create(
        dynasty_id: dynasty,
        season_number: season,
        team_id: team_id,           
        first_name: row["First Name"],         
        last_name: row["Last Name"],          
        position: row["Position"],           
        year: row["Year"],               
        overall: row["Overall"],            
        hometown: row["HomeTown"],           
        speed: row["Speed"],              
        strength: row["Strength"],           
        agility: row["Agility"],            
        acceleration: row["Acceleration"],       
        jumping: row["Jumping"],            
        awareness: row["Awareness"],          
        stamina: row["Stamina"],            
        injury: row["Injury"],             
        break_tackle: row["Break Tackle"],       
        trucking: row["Trucking"],           
        elusiveness: row["Elusiveness"],        
        stif_farm: row["Stif Farm"],          
        spin_move: row["Spin Move"],          
        juke_move: row["Juke Move"],          
        carrying: row["Carrying"],           
        ball_carrier_vision: row["Ball Carrier Vision"],
        pass_block: row["Pass Block"],         
        run_block: row["Run Block"],          
        catching: row["Catching"],           
        spectacular_catch: row["Spectacular Catch"],  
        catch_in_traffic: row["Catch In Traffic"],   
        route_running: row["Route Running"],      
        release: row["Release"],            
        tackle: row["Tackle"],             
        hit_power: row["Hit Power"],          
        pursuit: row["Pursuit"],            
        play_recognition: row["Play Recognition"],   
        power_moves: row["Power Moves"],        
        finesse_moves: row["Finesse Moves"],      
        block_shedding: row["Block Shedding"],     
        man_coverage: row["Man Coverage"],
        zone_coverage: row["Zone Coverage"],
        press: row["press"],
        throw_power: row["Throw Power"],
        throw_accuracy: row["Throw Accuracy"],
        kick_power: row["kick Power"],
        kick_accuracy: row["kick Accuracy"]
      )
    end
  end
  
  
  def self.update_players_stats(dynasty, season, csv_upload)
    #CSV.foreach(csv_upload, 
    #        :headers => true, 
    #        :header_converters => :symbol, 
    #        :converters => :all)
    CSV.foreach(csv_upload, 
        :headers => true, 
        :converters => :all)  do |row|
      player_name = row["Name"].split(" ")
      first_name  = player_name[0]
      last_name   = player_name[1]
      player = Player.where(:first_name => first_name, :last_name => last_name).first 
      player.attempts = row["Attempts"]           
      player.completion = row["Completion"]         
      player.interception = row["Interception"]       
      player.touch_downs = row["Touch Downs"]        
      player.yards = row["Yards"]              
      player.fumbles = row["Fumbles"]            
      player.long = row["Long"]               
      player.catches = row["Catches"]            
      player.fga = row["FGA"]                
      player.fgs = row["FGS"]                
      player.points = row["Points"]             
      player.xpa = row["XPA"]                
      player.xpm = row["XPM"]                
      player.ff = row["FF"]                 
      player.fr = row["FR"]                 
      player.sacks = row["Sacks"]              
      player.tackles_for_loss = row["Tackles For Loss"]   
      player.tackles = row["Tackles"]            
      player.save!
    end
  end

end

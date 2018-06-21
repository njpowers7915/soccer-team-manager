class Helpers

#Confirms current team for which the user has access to edit
    def self.current_team(session)
        @team = Team.find_by(id: session[:team_id])
    end

#Confirms whether or not user is logged in or out
    def self.is_logged_in?(session)
        @team = Team.find_by(id: session[:team_id])
        !@team.nil?
    end
end

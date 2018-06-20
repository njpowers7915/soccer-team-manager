class Helpers
    def self.current_team(session)
        @team = Team.find_by(id: session[:team_id])
    end

    def self.is_logged_in?(session)
        @team = Team.find_by(id: session[:team_id])
        !@team.nil?
    end
end

module CliWikiBashCompletionFeature
  class TicketToRide < Cli::Command
    class Options
      string "--by", any_of: %w(train plane taxi), default: "train"
      arg "for", any_of: %w(kyoto kanazawa kamakura)
    end
  end
end
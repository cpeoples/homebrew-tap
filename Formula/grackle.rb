class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.5/grackle-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "3e490fb51a3848241cae48dc9ee2ba447a68d4db5a55f1feb479b403002d5581"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.5/grackle-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "905f4af6b2b2de1b4fb90a5f26052f46d8955dd0316a626b2076a3ff20900ce9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.5/grackle-v0.1.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f2577d63135d1eb40a4937fb2d1d7572f038461fd893829c00a66192f67af5e0"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.5/grackle-v0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "07eaa520ad5b92c7414328c73f9094d3e068415b2a3764cc57d5afb274e3714d"
    end
  end

  def install
    bin.install "grackle"
  end

  test do
    assert_match "grackle", shell_output("#{bin}/grackle --version")
    assert_match "rules.", shell_output("#{bin}/grackle --list-rules")

    (testpath/"wf.yml").write <<~YAML
      on:
        issue_comment:
          types: [created]
      jobs:
        agent:
          permissions:
            contents: write
          steps:
            - run: pip install aider-chat
            - run: aider --yes --message "$(cat task.md)"
    YAML

    require "json"
    report = JSON.parse(shell_output("#{bin}/grackle --format json #{testpath}/wf.yml", 1))
    refute_empty report, "grackle should flag a fork-triggerable write-capable agent"
  end
end

class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.0/grackle-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "c6f4011e32eb51869751dfd4db2a84b4379cd1658c3e7acfa3e1d7855197d504"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.0/grackle-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "cfd53b32a55d6224cfa597dc1833d21fc92d5b389edd49c2f92a34d62aa9deae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.0/grackle-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "001985158a837cf44cea0784a97425c0ef7a5aca81ba91ee3ee03db351a59615"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.0/grackle-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b0c3b8b1a23dba65715eed6becde54dc75a51e251e504fc7af0b786e316d5b2"
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

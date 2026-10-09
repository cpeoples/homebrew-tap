class Cudabom < Formula
  desc "CUDA bill of materials: identify CUDA components and match known advisories"
  homepage "https://github.com/cpeoples/cudabom"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.0.0/cudabom-v0.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.0.0/cudabom-v0.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.0.0/cudabom-v0.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.0.0/cudabom-v0.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "cudabom"
  end

  test do
    assert_match "cudabom", shell_output("#{bin}/cudabom version")
    assert_match "scan", shell_output("#{bin}/cudabom --help")
  end
end

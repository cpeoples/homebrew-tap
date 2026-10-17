class Cudabom < Formula
  desc "CUDA bill of materials: identify CUDA components and match known advisories"
  homepage "https://github.com/cpeoples/cudabom"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "fb3dfc331d1beb563065eaa288ffbbe6332cf0b0a1076d79c25d90b0058fc3bf"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "849d7055e0f133b14a1d0e011f50352dd648c172ba581ad5273fc88e77638a36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23f40a805aa29b135bf31416fc727ba4b3a0ccb08e0080ab7e900f2c2811db71"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8a1d9b0b00ecf33e2177eced9879912e6d7443dcad4f10137892483acf3d226"
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

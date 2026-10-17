class Cudabom < Formula
  desc "CUDA bill of materials: identify CUDA components and match known advisories"
  homepage "https://github.com/cpeoples/cudabom"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "36439fdc8184dc175f1636f46110a2b3d43a196026ef077b6910f6c2a91fed96"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "d2bb3fd22e18761ecece939f1472ffd990d94f74090c9ba4f39e884e9a41dc0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3202429c3617ff90cd42254cf156d91ed360846f3701c012cd9e28a669970e19"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49686befeb6d19251179b3296fbd061849405856704a53a0a9576aeb7d060bfb"
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

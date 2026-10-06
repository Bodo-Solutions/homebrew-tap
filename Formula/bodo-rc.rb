# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1006.3668-rc/bodo-darwin-arm64"
  version "2026.1006.3668-rc"
  sha256 "25030a71692bfc3180ce6c28b70a83fc1762c05b478ce7ddc9930cacbc070ac8"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1006.3668-rc/bodo-linux-arm64"
      sha256 "971ee227f4260be779e22346cd9f8a978584e5470b5f23aa9c9c1058fe7dd0a2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1006.3668-rc/bodo-linux-x64"
      sha256 "55cd84a2b7c96b426db0b3bc329ff7fc73d1f9bfeb7b5b4a8c481f1d1f57a5b5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

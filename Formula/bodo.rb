# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1005.3630/bodo-darwin-arm64"
  version "2026.1005.3630"
  sha256 "d904c8f71191b5695b38ae0988a0755912c725fd23e3d4d71729fbc8f2a5c1bb"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1005.3630/bodo-linux-arm64"
      sha256 "47234536b337a0d270674c09d788d16434f536ac122ce0278efadc1d7a1cc2c4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1005.3630/bodo-linux-x64"
      sha256 "8aae0998358e1dbbf0b083d7b67e7fb509984f76d5e74e1482d9e14e36553846"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

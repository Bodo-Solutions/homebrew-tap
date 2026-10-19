# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4068-rc/bodo-darwin-arm64"
  version "2026.1019.4068-rc"
  sha256 "e27a4cc64a9fca74ea405152d4cbd6af5a6b0d52a828b37407eeeae725db0409"
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
      url "https://cli.bodo-app.com/v/2026.1019.4068-rc/bodo-linux-arm64"
      sha256 "ba42a2837c52a77dc2f3c10c18e20dc1a881c1118ce111e8d432b3ac09b34c89"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4068-rc/bodo-linux-x64"
      sha256 "92b3642a195e5790fc3894c68d714d65a7c7f82b1f2253dba84aa3ebc24dd9fd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

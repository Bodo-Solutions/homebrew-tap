# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4455-rc/bodo-darwin-arm64"
  version "2026.1026.4455-rc"
  sha256 "6005e5346ad6d62a4c16322ce1315ea7eddc1cd449c60399444fc6996ffdaa69"
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
      url "https://cli.bodo-app.com/v/2026.1026.4455-rc/bodo-linux-arm64"
      sha256 "d25dcd549ffc1fc2d44535d10e996a8dfa87b245559eb6adc13d81cf71f319d7"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4455-rc/bodo-linux-x64"
      sha256 "4867d7f07ee520b1355e38f1a9e981c4a35cb433942a3d7fa65146999a133afd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

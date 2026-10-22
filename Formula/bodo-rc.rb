# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4208-rc/bodo-darwin-arm64"
  version "2026.1022.4208-rc"
  sha256 "1061c766477b6a2f50f5af12f2b97d39fa7febc8dbf15f68ca055a343d170a90"
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
      url "https://cli.bodo-app.com/v/2026.1022.4208-rc/bodo-linux-arm64"
      sha256 "255fdd9566fdc223bd010af5e7e314b7b24dc4a190a9267c88c07f8475973766"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4208-rc/bodo-linux-x64"
      sha256 "faad29d629c684e6d7a21aac95a6ea2b086d9fb4a809b2393ea39acff87d6ef3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

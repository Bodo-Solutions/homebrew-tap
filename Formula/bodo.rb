# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1003.3557/bodo-darwin-arm64"
  version "2026.1003.3557"
  sha256 "f206e4b0ab30924653a2c6c86f69fc9c28b78a66f685e392ceecff891ab0a871"
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
      url "https://cli.bodo-app.com/v/2026.1003.3557/bodo-linux-arm64"
      sha256 "33586a17d47427ba16286d4bf4860394d187e030d27292172905f867544a2f61"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1003.3557/bodo-linux-x64"
      sha256 "05966dc2ec46671a18d87c4ed27d518967e98efd841663d82f1dd78c7d3c5043"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

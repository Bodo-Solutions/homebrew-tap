# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1030.4667/bodo-darwin-arm64"
  version "2026.1030.4667"
  sha256 "1311f5fd6f387d00547afe1cf9ac2a9eb364e07fa708621e90cef86222024e02"
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
      url "https://cli.bodo-app.com/v/2026.1030.4667/bodo-linux-arm64"
      sha256 "5ecbc3e5d27ce072d26e4bdd772ab7a22fc5d13bdf13d13f73a4c539406ab696"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1030.4667/bodo-linux-x64"
      sha256 "1b5edda5c83802e0935e874a0524f7d48b09e2bb29bf95ecf896e678fe5fca6b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

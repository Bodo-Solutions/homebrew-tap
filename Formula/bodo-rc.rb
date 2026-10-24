# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4332-rc/bodo-darwin-arm64"
  version "2026.1024.4332-rc"
  sha256 "33f366fc8fb3c9ceb117c87c70926ecd103e51be962436c67f5c974b8224ffef"
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
      url "https://cli.bodo-app.com/v/2026.1024.4332-rc/bodo-linux-arm64"
      sha256 "e1571183aebb5a7ab98e4fc3ef8a2c469489c125ba23bf3e4098df8632e5c3b3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4332-rc/bodo-linux-x64"
      sha256 "b58753bf00bb7060864902b16d0c33762d7f9532d943b77eaf113ce78699c548"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

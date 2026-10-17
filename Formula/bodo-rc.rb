# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1017.4025-rc/bodo-darwin-arm64"
  version "2026.1017.4025-rc"
  sha256 "8a315efb37c9c38fab150867012acd80610fb869ad3d7840c3c510c344172a9c"
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
      url "https://cli.bodo-app.com/v/2026.1017.4025-rc/bodo-linux-arm64"
      sha256 "d8e9a567ce94d2bc35c9270d1a28a8faf25b6df6ec39d1406c2db4c17f491941"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1017.4025-rc/bodo-linux-x64"
      sha256 "11e2b134b3b47f3a354bb8354b2059d26d9dd9a46c9431c2be340bd68647c1dd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

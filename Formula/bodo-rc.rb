# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.4004-rc/bodo-darwin-arm64"
  version "2026.1016.4004-rc"
  sha256 "d4dd32808d169d07498d9e6a97b1f5c5bb0a545503b8d2e687aac96c596f0c57"
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
      url "https://cli.bodo-app.com/v/2026.1016.4004-rc/bodo-linux-arm64"
      sha256 "db430e13d8d1cf3d07b280622207d9e75fbfd828efc89b37b9afda1e95ed5704"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.4004-rc/bodo-linux-x64"
      sha256 "e83d57306c505a3720317a2fb862505939134c476b5674aaaed0cba867236173"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

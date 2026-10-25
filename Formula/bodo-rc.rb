# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4380-rc/bodo-darwin-arm64"
  version "2026.1025.4380-rc"
  sha256 "df8c0ce858cee87dbe2efcc0a517d7ea22b2f241e78a01454daeade0943b8719"
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
      url "https://cli.bodo-app.com/v/2026.1025.4380-rc/bodo-linux-arm64"
      sha256 "3aad4f6f4b594471bf74ff3a160b8e09b9f2b8db5e47d8c39b89681c064f329c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4380-rc/bodo-linux-x64"
      sha256 "73c8cfefb4276a147cbe5fe4b1fa439cd077c5d56e92651bbb27b74b1a786876"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

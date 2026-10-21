# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4164-rc/bodo-darwin-arm64"
  version "2026.1021.4164-rc"
  sha256 "6df5e7157a393c33387c01902b5587dad823452d715909affb2103fc8e53edb7"
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
      url "https://cli.bodo-app.com/v/2026.1021.4164-rc/bodo-linux-arm64"
      sha256 "59a2cb2f2b9a98e59510291f7648458615f2ddcf97f12563842fe17ee928f1d4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4164-rc/bodo-linux-x64"
      sha256 "837fe61bb8b172ecee24df2489ac8dae8a9fef76113213bcbe65a7f93908f6a5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

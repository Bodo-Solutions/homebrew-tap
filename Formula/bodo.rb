# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1107.4708/bodo-darwin-arm64"
  version "2026.1107.4708"
  sha256 "07b8edac79ff44486282329712e9fdc79fb09d341f0bab2e5aebbab238bc87c2"
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
      url "https://cli.bodo-app.com/v/2026.1107.4708/bodo-linux-arm64"
      sha256 "a140e0097adf052770bae7d5ea0d20b052c092a2e54f66dd2af822c6c1c474d4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1107.4708/bodo-linux-x64"
      sha256 "9cf79e885ce12c26062e20b724c4d4e4f03e25142628faad5f853e8c949d5014"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

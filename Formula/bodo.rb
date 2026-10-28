# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4540/bodo-darwin-arm64"
  version "2026.1028.4540"
  sha256 "0b224bba5421cebe7d6be1e2ce2625ad695171dcba82381d13134c4c5aa50b0f"
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
      url "https://cli.bodo-app.com/v/2026.1028.4540/bodo-linux-arm64"
      sha256 "e2316140b81575de546904a02985ba1716a591c0a1d4c79831a529ad46527b36"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4540/bodo-linux-x64"
      sha256 "74367d93aa2cc9bc5cdc1013b04b4b262a8a002266edce379b5e78f980c3e52e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

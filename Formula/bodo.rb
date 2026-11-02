# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1102.4691/bodo-darwin-arm64"
  version "2026.1102.4691"
  sha256 "b9cb736a05bfd477c46612ee617aa9764077ff099768ea082e7a845999c3e0c2"
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
      url "https://cli.bodo-app.com/v/2026.1102.4691/bodo-linux-arm64"
      sha256 "f2f03834a2956beac27626b3ff7b452eeeee291bc09140622dab9ffeeed336ed"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1102.4691/bodo-linux-x64"
      sha256 "8831a2172acca3938cce38aa6aada070e095bc77882d5be24333f6c84916a81b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end

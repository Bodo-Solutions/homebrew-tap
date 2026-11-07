# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1107.4703/bodo-darwin-arm64"
  version "2026.1107.4703"
  sha256 "6ab4fa3dc2a4ee743909783845f626ba887fa0faef2e02263bb4285ba2cf6701"
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
      url "https://cli.bodo-app.com/v/2026.1107.4703/bodo-linux-arm64"
      sha256 "dac5b574c6ebac96962ae2e2f36584232dc2ae2efc9827393b098f37c60822c9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1107.4703/bodo-linux-x64"
      sha256 "8d5e08d57e575e4c39156314964837230fca0f6ecbd04f8454c59d821e885e33"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
